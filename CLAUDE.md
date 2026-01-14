# Executive Assistant Framework

  Project to build a self-bootstrapping AI command centre.

  ## What This Is
  A framework that onboards any executive through conversation and generates its own CLAUDE.md, skills, workflows, agents, and hooks.

  ## Constraints
  - British English
  - Minimal complexity
  - Observable verification criteria in all workflows
  - Blog-article quality code and documentation

  ## Key Files
  - `ARCHITECTURE.md` - System design
  - `examples/` - Templates for skills, workflows, agents, hooks
  - `.claude/bootstrap/` - Onboarding system (being built)

  ## Not To Confuse
  This CLAUDE.md describes the *framework project*. The framework *generates different* CLAUDE.md files for end users based on their onboarding answers.

  ## Memory Server

MCP memory server is available for the knowledge graph.

**When to use:**
- Storing entities discovered during development (patterns, decisions)
- NOT for storing framework design (that's in ARCHITECTURE.md)

**Entity naming:** lowercase, hyphenated (e.g., `onboarding-phase-1`, `skill-pattern`)

**Commands:**
- `mcp__memory__search_nodes(query)` - Find entities
- `mcp__memory__create_entities(entities)` - Add new
- `mcp__memory__add_observations(observations)` - Append to existing

## Self-Improvement Protocol (Generated Systems)

Generated command centres include organic self-improvement. This is NOT a skill to invoke - it's a behavioural layer woven into CLAUDE.md.

### How It Works

**Observe (Always Active)**
During all work, the assistant notices:
- Manual operations performed repeatedly
- Data needed but not available
- Corrections to output
- Friction in existing workflows
- Gaps in capabilities

When noticed: log observation to memory graph entity `improve-{slug}`, continue main task without interrupting user.

**Surface (Contextually)**
Propose improvements when:
- Doing the thing again AND have 3+ prior observations
- Finishing a task in the relevant area
- Natural conversation pause

Propose concretely: not "we should improve X" but "I've done X manually 5 times - shall I create a workflow?"

**Implement (On Approval)**
When approved:
1. Create/update skill, workflow, or CLAUDE.md
2. Add "IMPLEMENTED: {date}" observation to memory entity
3. Confirm briefly, continue with work

**Boundaries**
- Never propose during first 5 sessions (establish baseline)
- Never interrupt urgent/time-sensitive work
- Maximum 1 proposal per session unless asked
- If declined 2x, stop proposing that specific improvement

### Memory Entity Lifecycle

```
observed → maturing → proposed → implemented (or declined)
```

Implemented improvements archived to `reference/system/improvements.md` after 30 days, then deleted from memory graph.