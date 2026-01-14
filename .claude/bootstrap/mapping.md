# Onboarding → Output Mapping

How each piece of captured data flows into generated outputs.

---

## Identity Fields

| Field | Generated Output | Location |
|-------|------------------|----------|
| Name | CLAUDE.md header: "Helping **{Name}**" | `CLAUDE.md` |
| Name | Memory entity | Memory graph |
| Title | CLAUDE.md header: "{Company} {Title} Command Centre" | `CLAUDE.md` |
| Title | Skill path slugs (e.g., `vp-engineering-hiring`) | `.claude/skills/` |
| Company | CLAUDE.md header | `CLAUDE.md` |
| Company | Context in all prompts | `CLAUDE.md` rules |
| Reports to | Manager profile | `people/manager.md` |
| Reports to | Memory entity + relationship | Memory graph |
| Manager title | Manager profile | `people/manager.md` |
| Timezone | CLAUDE.md rule: "All times in {timezone}" | `CLAUDE.md` |
| Timezone | Calendar and scheduling logic | Workflow context |

---

## Responsibility Fields

| Field | Generated Output | Location |
|-------|------------------|----------|
| Responsibility name | Skill name and header | `.claude/skills/{slug}/SKILL.md` |
| Responsibility name | CLAUDE.md skills table | `CLAUDE.md` |
| Success criteria | Skill purpose section | `SKILL.md` Purpose |
| Success criteria | Workflow verification criteria | `SKILL.md` workflows |
| Collaborators | Related people references | `SKILL.md` Related Files |
| Collaborators | Memory relationships | Memory graph |
| Data tracked | Skill data locations section | `SKILL.md` Data Locations |
| Data tracked | Reference file structure | `reference/{skill}/` |
| Recurring tasks | Workflows within skill | `SKILL.md` Workflows |
| Recurring tasks | Agent triggers | `.claude/agents/` |

### Responsibility → Skill Example

**Input:**
```markdown
### Engineering Hiring
- **Success criteria:** 90-day retention above 85%, hiring velocity matches roadmap
- **Collaborators:** Talent team, hiring managers
- **Data tracked:** Pipeline in Greenhouse, offer acceptance rate
- **Recurring tasks:**
  - Weekly pipeline review
  - Monthly hiring retro
```

**Output:** `.claude/skills/hiring/SKILL.md`
```markdown
---
name: hiring
description: Engineering hiring and team growth. Use for pipeline reviews, candidate evaluations, offer decisions, hiring retrospectives, and workforce planning.
---

# Hiring

## Purpose
Grow the engineering team effectively. Success: 90-day retention above 85%, hiring velocity matches roadmap.

## Data Locations
- `reference/hiring/pipeline.md` - Current pipeline status
- `reference/hiring/metrics.md` - Offer acceptance rate, time-to-hire
- External: Greenhouse (ATS)

## Workflows

### Weekly Pipeline Review

**When:** Every Monday or when preparing for hiring sync

**Input:**
- Current pipeline state from Greenhouse
- Open roles from `reference/hiring/open-roles.md`

**Process:**
1. Review each open role's pipeline health
2. Identify bottlenecks (stages with stale candidates)
3. Flag candidates needing decisions this week
4. Check interviewer availability

**Output:**
Pipeline summary with action items for talent team sync

**Verification:**
- [ ] Every open role reviewed
- [ ] Stale candidates (>7 days in stage) flagged
- [ ] This week's interviews confirmed

**Next:** Share with talent team, update `work/actions.md`

---

### Monthly Hiring Retro

**When:** First week of each month

...
```

---

## People Fields

| Field | Generated Output | Location |
|-------|------------------|----------|
| Manager name | Profile file | `people/manager.md` |
| Manager name | Memory entity | Memory graph |
| Manager priorities | Profile content | `people/manager.md` |
| Manager update prefs | CLAUDE.md context | Agent behaviour |
| Direct report name | Profile file | `people/team/{name}.md` |
| Direct report name | Memory entity | Memory graph |
| Direct report role | Profile content | `people/team/{name}.md` |
| Direct report focus | Profile content, 1:1 prep | Workflow context |
| Stakeholder name | Profile file | `people/stakeholders/{name}.md` |
| Stakeholder name | Memory entity | Memory graph |
| Stakeholder relationship | Memory relationship | Memory graph |
| Communication prefs | Profile content | Person profile files |

### Person → Memory Entity Example

**Input:**
```markdown
#### Sarah Chen
- **Role:** Senior Engineering Manager
- **Tenure:** 2 years
- **Current focus:** Platform reliability
- **Development areas:** Strategic communication
- **Communication:** Slack, weekly 1:1 Thursdays
```

**Output:** Memory graph entity
```
Entity: sarah-chen
Type: direct-report
Observations:
  - "Role: Senior Engineering Manager"
  - "Reports to: {user_name}"
  - "Tenure: 2 years (as of {onboarding_date})"
  - "Current focus: Platform reliability"
  - "Development area: Strategic communication"
  - "Prefers: Slack"
  - "1:1: Thursdays weekly"
```

**Output:** `people/team/sarah-chen.md`
```markdown
# Sarah Chen

**Role:** Senior Engineering Manager
**Tenure:** 2 years
**1:1:** Thursdays weekly

## Current Focus
Platform reliability

## Development Areas
- Strategic communication

## Communication
- Primary: Slack
- Cadence: Weekly 1:1 Thursdays

## Notes

<!-- Updated by assistant over time -->
```

---

## Cadence Fields

| Field | Generated Output | Location |
|-------|------------------|----------|
| Meeting type | Workflow in relevant skill | `SKILL.md` workflows |
| Meeting frequency | Agent scheduling | `.claude/agents/weekly-prep.md` |
| Meeting participants | Workflow input | `SKILL.md` workflows |
| Meeting purpose | Workflow purpose | `SKILL.md` workflows |
| Reporting cycles | Workflows | Relevant `SKILL.md` |
| Key dates | Reference file | `reference/calendar/key-dates.md` |
| Key dates | Agent awareness | Weekly prep context |

### Meeting → Workflow Example

**Input:**
```markdown
| Team standup | Team meeting | Daily | Engineering team | Coordination |
```

**Output:** Workflow in team management skill
```markdown
### Daily Standup Prep

**When:** Each morning before standup (or when asked)

**Input:**
- Yesterday's standup notes
- Current sprint board
- Any blockers from Slack

**Process:**
1. Review what each team member committed to yesterday
2. Check sprint board for blocked items
3. Note any cross-team dependencies
4. Prepare any announcements

**Output:**
Brief standup prep notes

**Verification:**
- [ ] Blockers identified
- [ ] Dependencies noted

**Next:** Run standup, capture follow-ups in `work/actions.md`
```

---

## Preference Fields

| Field | Generated Output | Location |
|-------|------------------|----------|
| Language | CLAUDE.md rule | `CLAUDE.md` |
| Tone | CLAUDE.md communication style | `CLAUDE.md` |
| Format preferences | CLAUDE.md rules | `CLAUDE.md` |
| Working hours | CLAUDE.md context | `CLAUDE.md` |
| Focus time | Scheduling awareness | Agent behaviour |
| Needs help with | Priority skill generation | Skill selection |
| Blind spots | CLAUDE.md reminders | `CLAUDE.md` rules |
| Frustrations | CLAUDE.md "never do" rules | `CLAUDE.md` |
| Never do | CLAUDE.md hard rules | `CLAUDE.md` |

### Preferences → CLAUDE.md Example

**Input:**
```markdown
### Communication
- **Language:** British English
- **Tone:** Direct and brief
- **Format:** Bullet points, executive summary first

### Self-Awareness
- **Blind spots:** Tend to forget to update stakeholders
- **Frustrations:** Long-winded explanations, unnecessary meetings
- **Never do:** Don't schedule meetings before 9am
```

**Output:** CLAUDE.md sections
```markdown
## Communication Style

- British English always
- Direct and brief - no waffle
- Lead with executive summary, then supporting bullets
- Tables are fine for structured data

## Rules

1. All dates and times in Europe/London timezone
2. Remind me to update stakeholders after significant decisions
3. Never suggest meetings before 9am
4. Keep explanations concise - if I need more detail, I'll ask

## What To Avoid

- Long-winded explanations
- Suggesting unnecessary meetings
- Burying the lead in lengthy context
```

---

## Universal Outputs

These are generated regardless of onboarding answers:

| Output | Purpose | Location |
|--------|---------|----------|
| Self-improvement protocol | Organic learning behaviour | `CLAUDE.md` section |
| Session skill | Context management | `.claude/skills/session/` |
| Humanize skill | Voice matching | `.claude/skills/humanize/` |
| Weekly prep agent | Monday planning | `.claude/agents/weekly-prep.md` |
| Health check agent | Pre-meeting status | `.claude/agents/health-check.md` |
| Actions file | Task tracking | `work/actions.md` |
| Improvements file | System evolution | `reference/system/improvements.md` |
| Check-actions hook | Consistency reminder | `.claude/hooks/check-actions.sh` |
| Check-memory hook | Memory update reminder | `.claude/hooks/check-memory.sh` |

---

## Generation Order

1. **CLAUDE.md** - Core configuration (identity + preferences + rules)
2. **Directory structure** - `people/`, `work/`, `reference/`
3. **People files** - Manager, direct reports, stakeholders
4. **Work files** - `actions.md` (empty template)
5. **Memory graph** - Seed with person entities and relationships
6. **Priority skills** - Top 5-7 responsibilities → skills with workflows
7. **Universal skills** - Session, humanize
8. **Agents** - Weekly prep, health check
9. **Hooks** - Check-actions, check-memory
10. **System files** - `improvements.md`, `patterns.md`

---

## Queued for Later

Items captured but not generated initially:

| Item | When Generated | Trigger |
|------|----------------|---------|
| Non-priority responsibilities | Weeks 2-4 | User works in that area |
| Additional stakeholder profiles | On mention | User discusses person without profile |
| Detailed meeting workflows | On use | User preps for that meeting type |
| Custom workflows | On pattern detection | Same manual work 3x |
