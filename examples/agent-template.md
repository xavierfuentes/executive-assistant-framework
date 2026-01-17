---
name: {agent-name}
description: {When to use this agent}
hooks:
  Stop:
    - type: prompt
      prompt: |
        Before stopping, verify:
        1. {Condition 1}
        2. {Condition 2}
        Respond with JSON: {"decision": "stop"} or {"decision": "continue", "reason": "..."}
---

# {Agent Name}

## Purpose

{What this agent aggregates/orchestrates}

## When to Run

{Trigger scenarios - when this agent should be invoked}

## Input Specification

### Invocation Methods

| Method | Example | Resolution |
|--------|---------|------------|
| Explicit command | `/{agent-name} {target}` | Direct target specification |
| Natural language | "{natural request}" | Extract intent and target |
| Contextual | "{time/context reference}" | Query context sources |

### Context Resolution

1. **Parse invocation** - Extract target, parameters, or contextual references
2. **Source lookup** (if available) - Query calendar, files, or MCP sources
3. **Memory lookup** - Check for relevant patterns in memory graph
4. **User clarification** - If ambiguous, ask: "{clarifying question}?"
5. **Minimal input** - If sources unavailable, ask for minimum required info

### When Details Unknown

**Minimum required:** {minimum information needed to proceed}

**Process:**
1. Ask: "{essential question}?"
2. Ask: "{optional question}?" (if helpful)
3. Proceed with available information

## Execution

This agent runs the following in parallel:

1. **{Task 1}** - Invokes `{skill}` skill, `{workflow}` workflow
2. **{Task 2}** - Invokes `{skill}` skill, `{workflow}` workflow

## Output

{Consolidated format description}

```markdown
# {Agent Output Title}
{date/context}

## {Section 1}
{content description}

## {Section 2}
{content description}
```

## Verification

Before completing:

- [ ] {Verification criterion 1}
- [ ] {Verification criterion 2}
- [ ] {Verification criterion 3}
- [ ] Output is actionable, not just informational

## Stop Hook Behaviour

### Decision Handling

| Decision | Action |
|----------|--------|
| `stop` | Complete normally, present output |
| `continue` | Address `reason`, re-verify (max 3 cycles) |

### Continue Cycle Resolution

| Pending Item | Recovery Action |
|--------------|-----------------|
| {Condition 1 from hook} | {How to resolve} |
| {Condition 2 from hook} | {How to resolve} |

### Forced Stop Conditions
- 3 continue cycles exhausted
- 60-second timeout on verification
- User explicitly requests stopping

## Integration

After agent completes:
- {Follow-up action 1}
- {Follow-up action 2}

## Customisation

Adapts based on:
- **{Factor 1}:** {how it affects behaviour}
- **{Factor 2}:** {how it affects behaviour}