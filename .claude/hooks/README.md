# Hooks

Hooks are shell scripts triggered by Claude Code at specific points during tool execution. They provide contextual reminders and guidance without blocking workflow.

## Design Principles

1. **Never block** - Hooks exit 0 unless a genuine blocking error occurs
2. **Fail safe** - Parsing failures result in silent exit, not errors
3. **Robust parsing** - Use proper JSON parsers, fall back gracefully
4. **Minimal output** - Only show reminders when relevant
5. **No emojis** - Keep output clean and professional

## JSON Input Schema

Hooks receive JSON on stdin with this structure:

```json
{
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/absolute/path/to/file.md",
    "content": "..."
  },
  "tool_result": "..."
}
```

The exact fields in `tool_input` vary by tool:
- **Write**: `file_path`, `content`
- **Edit**: `file_path`, `old_string`, `new_string`
- **Read**: `file_path`
- **Bash**: `command`

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success (continue execution) |
| 2 | Blocking error (halt execution, show error) |

**Important**: Exit code 1 is reserved. Use 0 for success and 2 for blocking errors only.

## JSON Parsing Strategy

Hooks use a cascade of parsers to ensure robust JSON handling:

### 1. jq (preferred)
```bash
if command -v jq &> /dev/null; then
    echo "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null
    return
fi
```

Handles: nested objects, escaped quotes, unicode, whitespace variations.

### 2. Python3 (fallback)
```bash
if command -v python3 &> /dev/null; then
    echo "$input" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('tool_input', {}).get('file_path', '') or '')
except Exception:
    print('')
" 2>/dev/null
    return
fi
```

Available on most systems. Handles same edge cases as jq.

### 3. grep/sed (last resort)
```bash
echo "$input" | grep -oE '"file_path"\s*:\s*"[^"]*"' | head -1 | sed 's/"file_path"\s*:\s*"//' | sed 's/"$//'
```

**Known limitations**:
- Fails on escaped quotes within values
- Fails on multi-line JSON formatting
- May match wrong field if multiple `file_path` keys exist

Only used when jq and python3 are unavailable.

## Writing New Hooks

1. Copy `examples/hook-template.sh` as your starting point
2. Use `set -euo pipefail` for safety
3. Read input with `INPUT=$(cat)`
4. Use the `extract_file_path` function pattern
5. Exit silently (0) if parsing fails or path doesn't match
6. Keep reminder text brief and actionable

## Existing Hooks

| Hook | Trigger | Purpose |
|------|---------|---------|
| `check-actions.sh` | Write/Edit to people/ or work/ | Remind to update actions.md |
| `check-memory.sh` | Write/Edit to people/*.md | Remind to update memory graph |

## Troubleshooting

### Hook Not Firing?

**Check configuration:**
```bash
cat .claude/settings.json | jq '.hooks'
```

**Verify matcher:**
- `Write|Edit` matches both Write and Edit tools
- The matcher is a regex pattern

**Check executable permissions:**
```bash
ls -la .claude/hooks/
chmod +x .claude/hooks/*.sh
```

### Parser Failing?

**Test parsing manually:**
```bash
echo '{"tool_name":"Write","tool_input":{"file_path":"/path/to/file.md","content":"test"}}' | ./.claude/hooks/check-actions.sh
```

**Check parser availability:**
```bash
command -v jq && echo "jq available"
command -v python3 && echo "python3 available"
```

### Testing During Development

**Manual trigger test:**
```bash
echo '{"tool_name":"Write","tool_input":{"file_path":"/project/people/team/alice.md","content":"# Alice"}}' | ./.claude/hooks/check-memory.sh
```

**Test with edge cases:**
```bash
# Empty input (should exit silently)
echo '{}' | ./.claude/hooks/check-actions.sh

# Missing file_path (should exit silently)
echo '{"tool_name":"Write"}' | ./.claude/hooks/check-actions.sh
```

### Common Issues

| Symptom | Likely Cause | Solution |
|---------|--------------|----------|
| No output at all | Hook not configured | Add to `.claude/settings.json` |
| "Permission denied" | Not executable | `chmod +x` the script |
| "command not found" | Bad shebang or path | Check `#!/bin/bash` and path quoting |
| Parsing errors | No jq/python3 | Install jq: `brew install jq` |
| Wrong file matched | Regex too broad | Tighten path matching pattern |

### Debugging Checklist

1. [ ] Hook file exists at path specified in settings.json
2. [ ] Hook has executable permission
3. [ ] Hook starts with `#!/bin/bash`
4. [ ] Hook uses `set -euo pipefail`
5. [ ] Exit codes are 0 or 2 only
6. [ ] JSON parser (jq or python3) is available
7. [ ] Output goes to stdout, debug to stderr
