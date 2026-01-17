#!/bin/bash
# Hook: {hook-name}
# Trigger: {PostToolUse|PreToolUse} on {tool} to {path pattern}
# Purpose: {What this hook does}

set -euo pipefail

INPUT=$(cat)

# Extract file path using robust JSON parsing
# Cascade: jq > python3 > grep (fallback)
extract_file_path() {
    local input="$1"

    # Try jq first (handles all edge cases)
    if command -v jq &> /dev/null; then
        echo "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null
        return
    fi

    # Fallback to Python
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

    # Last resort: simple grep (may fail on edge cases)
    echo "$input" | grep -oE '"file_path"\s*:\s*"[^"]*"' | head -1 | sed 's/"file_path"\s*:\s*"//' | sed 's/"$//'
}

FILE_PATH=$(extract_file_path "$INPUT")

# Exit silently if we couldn't extract a path
if [[ -z "$FILE_PATH" ]]; then
    exit 0
fi

# Check if path matches our trigger pattern
if [[ "$FILE_PATH" =~ {regex-pattern} ]]; then
    echo ""
    echo "REMINDER: {What the user should do}"
    echo ""
fi

exit 0  # Always exit 0 (informational, not blocking)
