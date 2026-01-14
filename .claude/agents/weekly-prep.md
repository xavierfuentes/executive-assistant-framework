---
name: weekly-prep
description: Monday planning agent. Run at start of week to review priorities, upcoming meetings, and open actions across all responsibility areas.
hooks:
  Stop:
    - type: prompt
      prompt: |
        Before stopping weekly prep, verify:
        1. All responsibility areas have been reviewed
        2. Actions.md has been updated with this week's priorities
        3. Key meetings this week have been identified
        4. Any overdue items have been flagged
        Respond with JSON: {"decision": "stop"} or {"decision": "continue", "reason": "..."}
---

# Weekly Prep

## Purpose

Start each week with clarity. This agent aggregates across all responsibility areas to produce a unified view of the week ahead: priorities, meetings, risks, and focus areas.

## When to Run

- Monday mornings (or first working day of week)
- When user asks for weekly overview
- After returning from time off

## Execution

This agent runs the following in parallel:

### 1. Actions Review
**Source:** `work/actions.md`

- Review all items in Urgent & Important quadrant
- Check for overdue items across all quadrants
- Identify items that have been sitting too long
- Surface anything delegated that needs follow-up

### 2. Calendar Scan
**Source:** User's calendar (if accessible) or ask user

- List key meetings this week
- Identify meetings requiring preparation
- Note any conflicting priorities
- Flag unusually heavy/light days

### 3. Responsibility Sweep
**Source:** All skills in `.claude/skills/`

For each responsibility skill:
- Check for recurring tasks due this week
- Review any skill-specific data for updates needed
- Note any dependencies or blockers

### 4. People Pulse
**Source:** `people/team/`, `people/stakeholders/`, memory graph

- Any 1:1s this week? Pull context for each
- Outstanding follow-ups with anyone?
- Anyone you haven't connected with recently?

### 5. Improvement Check
**Source:** Memory graph

- Query for improvement entities with 3+ observations
- Any mature enough to propose this week?
- Note but don't interrupt flow

## Output

Consolidated weekly brief:

```markdown
# Week of {date}

## Top Priorities This Week
1. {priority_1} - {context}
2. {priority_2} - {context}
3. {priority_3} - {context}

## Key Meetings
| Day | Time | Meeting | Prep Needed |
|-----|------|---------|-------------|
| Mon | 10am | {meeting} | {yes/no - what} |
| ... | ... | ... | ... |

## By Responsibility

### {Responsibility 1}
- {key focus this week}
- {any deadlines or deliverables}

### {Responsibility 2}
- {key focus this week}
- {any deadlines or deliverables}

## People
- **1:1s this week:** {list with day/time}
- **Follow-ups needed:** {any outstanding}

## Watch Items
- {anything at risk or needing attention}

## Overdue
- {any overdue actions - flag for decision}
```

## Verification

Before completing:

- [ ] All quadrants of actions.md reviewed
- [ ] Overdue items surfaced (not hidden)
- [ ] Each responsibility area considered
- [ ] Meetings requiring prep identified
- [ ] 1:1 context ready for scheduled 1:1s
- [ ] Output is actionable, not just informational

## Integration

After weekly prep:
- Update `work/actions.md` if priorities shifted
- Offer to prep for specific meetings
- Note any improvements observed during the process

## Customisation

This agent adapts based on onboarding:

- **Responsibilities:** Sweeps all generated skills
- **Meeting types:** Based on cadence section
- **People focus:** Based on team size and stakeholder count

If user has no direct reports, skip 1:1 context section.
If user has board meetings this week, add dedicated section.
