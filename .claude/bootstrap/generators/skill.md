# Skill Generator

Transforms a responsibility from onboarding into a full SKILL.md with workflows.

## Input Required

From `answers.md > Responsibilities > {responsibility}`:
- Name
- Success criteria
- Collaborators
- Data tracked
- Recurring tasks (with frequency)

## Output Location

`.claude/skills/{slug}/SKILL.md`

Where `{slug}` is the responsibility name converted to lowercase-hyphenated format.

---

## SKILL.md Template

```markdown
---
name: {slug}
description: {auto_discovery_description}
---

# {Responsibility Name}

## Purpose

{purpose_from_success_criteria}

## Data Locations

{data_locations_list}

## Workflows

{workflows_from_recurring_tasks}

## Related Files

{related_files_list}

## Best Practices

{generated_best_practices}
```

---

## Field Generation Logic

### Slug

Convert responsibility name to file-safe slug:
- "Engineering Hiring" → `hiring`
- "Technical Strategy and Architecture" → `strategy`
- "Team Performance Management" → `team-performance`

For compound names, use the most distinctive word if single-word slug is clear enough.

### Description (Auto-Discovery)

**Critical field** - determines when Claude uses this skill.

Formula:
```
{responsibility_name}. Use for {task_1}, {task_2}, {task_3}, and {success_metric} tracking.
```

Example:
```
Engineering hiring and team growth. Use for pipeline reviews, candidate evaluations, offer decisions, hiring retrospectives, and 90-day retention tracking.
```

Maximum 1024 characters. Be specific about triggers, not vague.

### Purpose

Derived from success criteria:
```
{Responsibility_name}. Success: {success_criteria}.
```

Example:
```
Grow the engineering team effectively. Success: 90-day retention above 85%, hiring velocity matches roadmap needs.
```

### Data Locations

From "Data tracked" field, convert to file paths:

| Tracked Data | Generated Path |
|--------------|----------------|
| "Pipeline in Greenhouse" | External: Greenhouse (ATS) |
| "Offer acceptance rate" | `reference/{slug}/metrics.md` |
| "Team feedback" | `reference/{slug}/feedback.md` |
| Generic metrics | `reference/{slug}/data.md` |

Template:
```markdown
## Data Locations

- `reference/{slug}/metrics.md` - Key metrics and tracking
- `reference/{slug}/notes.md` - Working notes and context
- External: {external_system} ({description})
```

### Workflows (From Recurring Tasks)

Each recurring task becomes a workflow section.

**Workflow template:**
```markdown
### {Task Name}

**When:** {frequency} or {trigger_description}

**Input:**
- {input_from_data_locations}
- {input_from_collaborators}

**Process:**
1. {generated_step_1}
2. {generated_step_2}
3. {generated_step_3}
4. {generated_step_4}

**Output:**
{output_description}

**Verification:**
- [ ] {observable_criterion_from_success_criteria}
- [ ] {observable_criterion_from_task}

**Next:** {follow_up_action}
```

### Related Files

Generated from collaborators and context:
```markdown
## Related Files

- `people/team/{collaborator}.md` - {role}
- `people/stakeholders/{collaborator}.md` - {role}
- `work/actions.md` - Action items from this skill
```

### Best Practices

Generated based on responsibility type. Common patterns:

**For hiring:**
- Document decisions with rationale
- Calibrate regularly with hiring managers
- Track time-in-stage to identify bottlenecks

**For strategy:**
- Capture context, not just decisions
- Review quarterly for relevance
- Link to business outcomes

**For team management:**
- Prepare before 1:1s, capture during
- Track patterns across individuals
- Separate observations from judgments

---

## Full Generation Example

### Input (from answers.md)

```markdown
### 1. Engineering Hiring
- **Priority:** initial
- **Success criteria:** 90-day retention above 85%, hiring velocity matches roadmap
- **Collaborators:** Talent team, hiring managers, Sarah Chen
- **Data tracked:** Pipeline in Greenhouse, offer acceptance rate, time-to-hire
- **Recurring tasks:**
  - Weekly pipeline review
  - Monthly hiring retrospective
```

### Output (.claude/skills/hiring/SKILL.md)

```markdown
---
name: hiring
description: Engineering hiring and team growth. Use for pipeline reviews, candidate evaluations, offer decisions, hiring retrospectives, workforce planning, and 90-day retention tracking.
---

# Engineering Hiring

## Purpose

Grow the engineering team effectively. Success: 90-day retention above 85%, hiring velocity matches roadmap needs.

## Data Locations

- `reference/hiring/pipeline.md` - Current pipeline status and notes
- `reference/hiring/metrics.md` - Offer acceptance rate, time-to-hire, retention
- `reference/hiring/roles.md` - Open roles and requirements
- External: Greenhouse (ATS)

## Workflows

### Weekly Pipeline Review

**When:** Every Monday, or before hiring syncs

**Input:**
- Current pipeline from Greenhouse
- Open roles from `reference/hiring/roles.md`
- Previous week's notes

**Process:**
1. Pull current pipeline state by role
2. Review each open role's funnel health
3. Identify stale candidates (>7 days in stage)
4. Flag candidates needing decisions this week
5. Check interviewer availability for scheduled interviews
6. Note any bottlenecks or concerns

**Output:**
Pipeline summary with:
- Status by role (healthy/at-risk/blocked)
- Candidates needing action
- Interviewer capacity issues
- Recommended focus areas

**Verification:**
- [ ] Every open role reviewed
- [ ] Candidates stale >7 days flagged
- [ ] This week's interviews confirmed
- [ ] Bottlenecks identified with owners

**Next:** Share with Talent team, update `work/actions.md` with follow-ups

---

### Monthly Hiring Retrospective

**When:** First week of each month

**Input:**
- Previous month's hiring activity
- Metrics from `reference/hiring/metrics.md`
- Feedback from hiring managers

**Process:**
1. Calculate month's metrics (offers, acceptances, starts, retention)
2. Compare to targets and previous months
3. Review any failed hires or declined offers
4. Gather feedback from hiring managers on process
5. Identify one process improvement to implement
6. Update forecasts for next month

**Output:**
Monthly hiring report with:
- Key metrics vs targets
- Wins and concerns
- Process improvement recommendation
- Updated forecast

**Verification:**
- [ ] All metrics calculated and compared to targets
- [ ] Declined offers analysed for patterns
- [ ] At least one improvement identified
- [ ] Forecast updated for next month

**Next:** Share with leadership, implement approved improvement, update `reference/system/improvements.md` if process change made

## Related Files

- `people/stakeholders/talent-team.md` - Talent/recruiting partners
- `people/team/sarah-chen.md` - Hiring manager
- `work/actions.md` - Hiring-related action items
- `reference/hiring/` - All hiring data and context

## Best Practices

- Document rejection rationale for calibration
- Track time-in-stage to spot bottlenecks early
- Calibrate with hiring managers monthly
- Review 90-day retention quarterly to catch patterns
```

---

## Workflow Generation Heuristics

When generating workflows from recurring tasks, use these patterns:

### Review-Type Tasks

"Weekly X review", "Monthly Y review"

```markdown
**Process:**
1. Gather current data from {source}
2. Compare to previous period / targets
3. Identify items needing attention
4. Prioritise by impact/urgency
5. Prepare summary for stakeholders

**Verification:**
- [ ] All items reviewed
- [ ] Exceptions flagged
- [ ] Actions assigned owners
```

### Sync/Meeting Prep Tasks

"Prep for X meeting", "X sync preparation"

```markdown
**Process:**
1. Review agenda / standing topics
2. Gather relevant updates
3. Identify discussion items
4. Prepare any materials needed
5. Note questions to raise

**Verification:**
- [ ] All agenda items have input prepared
- [ ] Open questions documented
- [ ] Materials ready
```

### Retrospective/Analysis Tasks

"Monthly retro", "Quarterly analysis"

```markdown
**Process:**
1. Collect data for period
2. Calculate key metrics
3. Compare to targets/previous periods
4. Identify patterns and themes
5. Propose improvements
6. Document learnings

**Verification:**
- [ ] Metrics calculated accurately
- [ ] Comparison to baseline complete
- [ ] At least one actionable insight
```

---

## Verification Checklist

After generating a skill:

- [ ] Slug is descriptive and unique
- [ ] Description is specific (triggers, not vague purposes)
- [ ] Purpose includes success criteria
- [ ] Data locations reference actual tracked data
- [ ] Each recurring task has a workflow
- [ ] Workflows have observable verification criteria
- [ ] Related files link to relevant people
- [ ] Best practices are relevant to the domain
- [ ] Total file under 500 lines

## Edge Cases

### No Recurring Tasks Specified

Generate one default workflow: "General {skill} review"
```markdown
### General {Skill} Review

**When:** When working on {responsibility} topics

**Process:**
1. Review current state
2. Identify priorities
3. Take action on top items

**Verification:**
- [ ] Current state understood
- [ ] Priorities clear
```

### Many Recurring Tasks (>5)

Include all as workflows, but:
- Order by frequency (weekly before monthly)
- Add note: "This skill has many workflows. Consider splitting if complexity grows."

### Vague Success Criteria

If success criteria is vague (e.g., "do it well"):
- Prompt for clarification during onboarding
- If not available, use: "Effective {responsibility} management."
- Flag for future improvement
