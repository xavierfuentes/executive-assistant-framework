# Sample Generated Output

What the generate skill creates from `sample-answers.md`. This shows expected output without actually creating files.

---

## Generated Directory Structure

```
{target}/
├── CLAUDE.md
├── people/
│   ├── manager.md
│   ├── team/
│   │   ├── mike-johnson.md
│   │   ├── lisa-park.md
│   │   ├── tom-wilson.md
│   │   └── rachel-green.md
│   └── stakeholders/
│       ├── amanda-liu.md
│       ├── david-kim.md
│       ├── emma-thompson.md
│       └── marcus-brown.md
├── work/
│   ├── actions.md
│   └── transcriptions/
├── reference/
│   ├── company/
│   │   └── overview.md
│   ├── process/
│   ├── guides/
│   └── system/
│       ├── improvements.md
│       └── patterns.md
├── me/
└── .claude/
    ├── skills/
    │   ├── hiring/
    │   │   └── SKILL.md
    │   ├── strategy/
    │   │   └── SKILL.md
    │   ├── team-performance/
    │   │   └── SKILL.md
    │   ├── delivery/
    │   │   └── SKILL.md
    │   ├── session/
    │   │   └── SKILL.md
    │   └── humanize/
    │       └── SKILL.md
    ├── agents/
    │   ├── weekly-prep.md
    │   └── health-check.md
    ├── hooks/
    │   ├── check-actions.sh
    │   └── check-memory.sh
    └── settings.json
```

---

## Sample CLAUDE.md

```markdown
# Acme Corp VP Engineering Command Centre

## Who You're Helping

**Sarah Chen** - VP Engineering at Acme Corp, reporting to James Wright (CTO).

Timezone: Europe/London

## Communication Style

Use British English always.

- Be direct and concise - no corporate fluff
- Get to the point, lead with the answer
- Use bullet points over prose
- Tables for structured data
- Executive summary first, detail on request

## Role Overview

Core responsibilities:
1. Engineering hiring and team growth
2. Technical strategy and architecture
3. Team performance and development
4. Delivery execution and sprint health

## Skills

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| hiring | Engineering hiring. Target: 90-day retention >85%, diverse pipeline | Pipeline reviews, candidate decisions, hiring retros |
| strategy | Technical strategy. Target: 10x scale, <20% tech debt | Architecture reviews, roadmap planning, tech decisions |
| team-performance | Team performance. Target: engagement >4.2, attrition <10% | 1:1 prep, performance reviews, engagement analysis |
| delivery | Delivery execution. Target: 80% commitments, <2 incidents/month | Sprint reviews, OKR check-ins, incident response |
| session | Context management | Start of session, before ending |
| humanize | Match my voice | Rewriting AI-generated text |

## Rules

### Always
1. Use British English
2. Express all dates and times in Europe/London timezone
3. Protect mornings (8:30-11am) - no meetings
4. Lead with recommendations, not options
5. Include metrics when discussing progress

### Never
1. Schedule meetings before 9am or after 5pm
2. Use corporate jargon
3. Add calendar items without context
4. Write long-winded explanations
5. Revisit decisions after they're made

### Reminders
- After significant decisions, remind me to update stakeholders
- Before board meetings (quarterly), start prep 2 weeks early
- When writing feedback, soften directness for written medium

## Self-Improvement Protocol

[Full protocol as defined in claude-md.md generator]

## Key Files

| File | Purpose |
|------|---------|
| `work/actions.md` | All action items (Eisenhower matrix) |
| `people/manager.md` | James Wright - CTO context |
| `people/team/` | Direct report profiles |
| `people/stakeholders/` | Key relationship profiles |
| `reference/system/improvements.md` | Implemented improvements log |
| `reference/system/patterns.md` | Learned patterns and anti-patterns |
```

---

## Sample Skill: hiring/SKILL.md

```markdown
---
name: hiring
description: Engineering hiring and team growth. Use for pipeline reviews, candidate evaluations, offer decisions, hiring retrospectives, workforce planning, source effectiveness analysis, and diversity metrics tracking.
user-invocable: true
---

# Engineering Hiring

## Purpose

Grow the engineering team effectively. Success: 90-day retention above 85%, hiring velocity matches roadmap needs, diverse pipeline maintained.

## Data Locations

- `reference/hiring/pipeline.md` - Current pipeline status
- `reference/hiring/metrics.md` - Offer acceptance rate, time-to-hire, source effectiveness
- `reference/hiring/roles.md` - Open roles and requirements
- External: Greenhouse (ATS)

## Workflows

### Weekly Pipeline Review

**When:** Every Monday, or before hiring sync at 3pm

**Input:**
- Current pipeline from Greenhouse
- Open roles from `reference/hiring/roles.md`
- Previous week's notes

**Process:**
1. Pull current pipeline state by role
2. Review each open role's funnel health
3. Identify stale candidates (>7 days in stage)
4. Flag candidates needing decisions this week
5. Check interviewer availability
6. Review diversity metrics by stage

**Output:**
Pipeline summary for hiring sync:
- Status by role (healthy/at-risk/blocked)
- Candidates needing action
- Interviewer capacity issues
- Diversity checkpoint

**Verification:**
- [ ] Every open role reviewed
- [ ] Candidates stale >7 days flagged
- [ ] This week's interviews confirmed
- [ ] Diversity metrics checked

**Next:** Share with Talent team at Monday 3pm sync

---

### Monthly Hiring Retrospective

**When:** First week of each month

**Input:**
- Previous month's hiring activity from Greenhouse
- Metrics from `reference/hiring/metrics.md`
- Feedback from hiring managers (Mike, Lisa)

**Process:**
1. Calculate month's metrics (offers, acceptances, starts)
2. Compare to targets and previous months
3. Analyse any declined offers or failed hires
4. Gather feedback from hiring managers
5. Identify one process improvement
6. Update workforce plan forecast

**Output:**
Monthly hiring report:
- Key metrics vs targets
- Wins and concerns
- Process improvement recommendation
- Updated forecast

**Verification:**
- [ ] All metrics calculated
- [ ] Declined offers analysed
- [ ] At least one improvement identified
- [ ] Forecast updated

**Next:** Share with James and Marcus

---

### Quarterly Workforce Planning

**When:** Start of each quarter

**Input:**
- Roadmap from Product
- Current headcount
- Attrition projections
- Budget constraints from Emma

**Process:**
1. Review product roadmap capacity needs
2. Map current team capabilities to needs
3. Identify gaps requiring hires
4. Prioritise roles by business impact
5. Build hiring timeline
6. Validate with budget

**Output:**
Quarterly workforce plan:
- Prioritised roles to open
- Timeline for each
- Budget impact
- Risks and dependencies

**Verification:**
- [ ] Roadmap capacity mapped
- [ ] Gaps identified
- [ ] Budget validated
- [ ] Plan reviewed with James

**Next:** Open approved roles in Greenhouse

## Related Files

- `people/stakeholders/marcus-brown.md` - Head of Talent
- `people/team/mike-johnson.md` - Hiring manager (backend)
- `people/team/lisa-park.md` - Hiring manager (frontend)
- `work/actions.md` - Hiring-related action items

## Best Practices

- Document rejection rationale for calibration
- Track time-in-stage to spot bottlenecks early
- Calibrate with hiring managers monthly
- Review 90-day retention quarterly
- Maintain diverse pipeline at top of funnel
```

---

## Sample Person: people/team/mike-johnson.md

```markdown
# Mike Johnson

**Role:** Senior Engineering Manager
**Tenure:** 18 months
**1:1:** Tuesdays 10am (weekly)

## Current Focus

- Backend platform ownership
- API redesign project (Q1 priority)

## Development Areas

- Cross-team collaboration
- Executive communication

## Communication

- **Primary channel:** Slack
- **Response style:** Quick, appreciates direct feedback

## Career Context

Strong technical background, growing into broader leadership. Ready for Director track discussion in 6-12 months.

## Recent Topics

| Date | Topics | Follow-ups |
|------|--------|------------|

## Notes

<!-- Observations added over time -->
```

---

## Memory Graph Entities Created

### User Entity
```
Entity: sarah-chen
Type: user
Observations:
  - "Role: VP Engineering at Acme Corp"
  - "Reports to: James Wright (CTO)"
  - "Timezone: Europe/London"
  - "Onboarded: 2024-01-15"
```

### Manager Entity
```
Entity: james-wright
Type: person
Observations:
  - "Role: CTO at Acme Corp"
  - "Relationship: sarah-chen's manager"
  - "Priorities: Platform scalability, team growth to 60, tech debt reduction"
  - "Update preference: Weekly async Friday, fortnightly sync"
  - "Profile: people/manager.md"
```

### Direct Report Entities
```
Entity: mike-johnson
Type: person
Observations:
  - "Role: Senior Engineering Manager"
  - "Reports to: sarah-chen"
  - "Tenure: 18 months"
  - "Focus: Backend platform, API redesign"
  - "Development: Cross-team collaboration, executive communication"
  - "1:1: Tuesdays 10am"
  - "Profile: people/team/mike-johnson.md"

Entity: lisa-park
...

Entity: tom-wilson
...

Entity: rachel-green
...
```

### Stakeholder Entities
```
Entity: amanda-liu
Type: person
Observations:
  - "Role: VP Product at Acme Corp"
  - "Relationship: Peer to sarah-chen"
  - "Context: Roadmap planning, capacity allocation, feature prioritisation"
  - "Communication: Slack quick, meetings for decisions, data-driven"
  - "Profile: people/stakeholders/amanda-liu.md"

Entity: david-kim
...

Entity: emma-thompson
...

Entity: marcus-brown
...
```

### Relationships Created
```
sarah-chen → james-wright (reports-to)
mike-johnson → sarah-chen (reports-to)
lisa-park → sarah-chen (reports-to)
tom-wilson → sarah-chen (reports-to)
rachel-green → sarah-chen (reports-to)
sarah-chen → amanda-liu (works-with)
sarah-chen → david-kim (works-with)
sarah-chen → emma-thompson (works-with)
sarah-chen → marcus-brown (collaborates-with)
```

---

## Generation Summary

| Category | Count |
|----------|-------|
| Directories created | 12 |
| CLAUDE.md | 1 |
| People profiles | 9 (1 manager + 4 team + 4 stakeholders) |
| Skills generated | 4 (hiring, strategy, team-performance, delivery) |
| Universal skills | 2 (session, humanize) |
| Agents | 2 (weekly-prep, health-check) |
| Hooks | 2 (check-actions, check-memory) |
| Memory entities | 10 (1 user + 1 manager + 4 reports + 4 stakeholders) |
| Memory relationships | 9 |
| **Total files** | **~25** |
