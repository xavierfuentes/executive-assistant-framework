# Structure Generator

Creates the directory structure and empty template files for a new command centre.

## Input Required

None - this generator creates the universal scaffolding.

## Directories Created

```
{project-root}/
├── people/
│   ├── team/           # Direct report profiles
│   └── stakeholders/   # Key relationship profiles
├── work/
│   └── transcriptions/ # Meeting notes
├── reference/
│   ├── company/        # Organisation context
│   ├── process/        # How the user works
│   ├── guides/         # Frameworks, style guides
│   └── system/         # Self-improvement data
└── me/                 # User's personal files
```

## Files Generated

### work/actions.md

```markdown
# Actions

Single source of truth for all action items. Updated continuously.

## Urgent & Important
*Do these today*

- [ ] {action} - {context} `{due date}`

## Important, Not Urgent
*Schedule these*

- [ ] {action} - {context} `{target date}`

## Urgent, Not Important
*Delegate if possible*

- [ ] {action} - {owner if delegated} `{due date}`

## Neither
*Consider dropping*

- [ ] {action}

---

## Completed This Week

| Date | Action | Outcome |
|------|--------|---------|

## Delegated & Waiting

| Action | Delegated To | Date | Follow-up |
|--------|--------------|------|-----------|
```

---

### reference/system/improvements.md

```markdown
# System Improvements

Log of implemented improvements to the assistant system.

## Recently Implemented

| Date | Improvement | Impact | Source |
|------|-------------|--------|--------|

## Declined

| Date | Proposal | Reason |
|------|----------|--------|

---

*Active improvement tracking happens in the memory graph.*
*Improvements are archived here after implementation.*
```

---

### reference/system/patterns.md

```markdown
# Patterns & Anti-Patterns

Learned patterns from working together. Referenced when generating outputs.

## Communication Patterns

### Do
- {pattern learned from corrections}

### Avoid
- {anti-pattern identified}

## Workflow Patterns

### Do
- {effective approach discovered}

### Avoid
- {ineffective approach identified}

## Domain-Specific

### {Responsibility Area}
- {pattern specific to this area}

---

*Updated when user corrects output or expresses preference.*
```

---

### reference/company/overview.md

```markdown
# Company Overview

Context about {company_name} for informed assistance.

## Basics

- **Name:** {company_name}
- **Industry:** {industry}
- **Stage:** {startup/scaleup/enterprise}
- **Size:** {employee_count}
- **Locations:** {locations}

## What We Do

{company_description}

## Current Priorities

- {priority_1}
- {priority_2}

## Key Products/Services

- {product_1}
- {product_2}

---

*Updated from onboarding and ongoing context.*
```

---

### people/manager.md (placeholder)

```markdown
# {Manager Name}

**Role:** {manager_title}
**Relationship:** My manager

## Priorities

- {priority}

## Update Preferences

- **Frequency:** {frequency}
- **Format:** {format}
- **Channel:** {channel}

## Meeting Cadence

- {meeting_type}: {frequency}

## Notes

<!-- Observations added over time -->
```

---

## Generation Commands

When generating a new command centre, execute these in order:

```bash
# Create directories
mkdir -p people/team people/stakeholders
mkdir -p work/transcriptions
mkdir -p reference/company reference/process reference/guides reference/system
mkdir -p me

# Create empty files from templates above
# (assistant writes each file using the templates)
```

### .claude/settings.json

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": {
          "tool": ["Write", "Edit"],
          "path": ["people/**/*", "work/**/*"]
        },
        "command": ".claude/hooks/check-actions.sh"
      },
      {
        "matcher": {
          "tool": ["Write", "Edit"],
          "path": ["people/**/*.md"]
        },
        "command": ".claude/hooks/check-memory.sh"
      }
    ]
  }
}
```

---

### .mcp.json

MCP server configuration for the generated command centre. Users will be prompted to install these servers when they first run Claude in the directory.

```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

---

## Verification

After generation:

- [ ] All directories exist
- [ ] `work/actions.md` created with Eisenhower matrix structure
- [ ] `reference/system/improvements.md` created
- [ ] `reference/system/patterns.md` created
- [ ] `reference/company/overview.md` created (even if minimal)
- [ ] `people/manager.md` placeholder created
- [ ] `.claude/settings.json` created with hook configuration
- [ ] `.mcp.json` created with memory and context7 servers
- [ ] Hook scripts are executable
