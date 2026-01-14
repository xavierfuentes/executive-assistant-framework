# Person Generator

Generates profile files for people in the user's professional network.

## Person Types

| Type | Location | Source |
|------|----------|--------|
| Manager | `people/manager.md` | `answers.md > People > Manager` |
| Direct Report | `people/team/{slug}.md` | `answers.md > People > Direct Reports` |
| Stakeholder | `people/stakeholders/{slug}.md` | `answers.md > People > Stakeholders` |

## Slug Generation

Convert name to file-safe slug:
1. Lowercase
2. Replace spaces with hyphens
3. Remove special characters
4. Example: "Sarah Chen" → `sarah-chen`

---

## Manager Template

**Location:** `people/manager.md`

```markdown
# {name}

**Role:** {title}
**Relationship:** My manager

## Current Priorities

{priorities_as_bullets}

## Update Preferences

- **Frequency:** {update_frequency}
- **Format:** {preferred_format}
- **What they care about:** {key_concerns}

## Meeting Cadence

| Meeting | Frequency | Purpose |
|---------|-----------|---------|
| 1:1 | {frequency} | {purpose} |
{additional_meetings}

## Communication Style

{communication_notes}

## Notes

<!-- Observations added over time -->
```

### Field Mapping

| Answer Field | Template Field |
|--------------|----------------|
| `People > Manager > Name` | `{name}` |
| `People > Manager > Title` | `{title}` |
| `People > Manager > Priorities` | `{priorities_as_bullets}` |
| `People > Manager > Update preferences` | `{update_frequency}`, `{preferred_format}` |
| `People > Manager > Meeting frequency` | `{frequency}` |
| `People > Manager > Notes` | `{communication_notes}` |

### Example Output

```markdown
# James Wright

**Role:** CTO
**Relationship:** My manager

## Current Priorities

- Platform scalability for enterprise customers
- Engineering team growth (target: 60 by Q3)
- Reducing technical debt in core systems

## Update Preferences

- **Frequency:** Weekly async update, fortnightly sync
- **Format:** Brief bullet points, metrics where relevant
- **What they care about:** Progress against hiring targets, major blockers, risk items

## Meeting Cadence

| Meeting | Frequency | Purpose |
|---------|-----------|---------|
| 1:1 | Weekly (Thursdays 2pm) | Updates, alignment, support |
| Leadership sync | Weekly (Mondays 10am) | Cross-functional coordination |

## Communication Style

Prefers Slack for quick questions, email for things needing a paper trail.
Appreciates when I flag risks early rather than waiting for them to escalate.

## Notes

<!-- Observations added over time -->
```

---

## Direct Report Template

**Location:** `people/team/{slug}.md`

```markdown
# {name}

**Role:** {role}
**Tenure:** {tenure}
**1:1:** {meeting_schedule}

## Current Focus

{focus_areas_as_bullets}

## Development Areas

{development_areas_as_bullets}

## Communication

- **Primary channel:** {channel}
- **Response style:** {style_notes}

## Career Context

{career_notes_if_available}

## Recent Topics

<!-- Updated after 1:1s -->

| Date | Topics | Follow-ups |
|------|--------|------------|

## Notes

<!-- Observations added over time -->
```

### Field Mapping

| Answer Field | Template Field |
|--------------|----------------|
| `Direct Reports > {name} > Name` | `{name}` |
| `Direct Reports > {name} > Role` | `{role}` |
| `Direct Reports > {name} > Tenure` | `{tenure}` |
| `Direct Reports > {name} > Current focus` | `{focus_areas_as_bullets}` |
| `Direct Reports > {name} > Development areas` | `{development_areas_as_bullets}` |
| `Direct Reports > {name} > Communication` | `{channel}`, `{style_notes}` |

### Example Output

```markdown
# Sarah Chen

**Role:** Senior Engineering Manager
**Tenure:** 2 years
**1:1:** Thursdays 10am (weekly)

## Current Focus

- Platform reliability improvements
- Growing the infrastructure team (2 open roles)
- Q1 OKR delivery

## Development Areas

- Strategic communication with executives
- Delegating more effectively

## Communication

- **Primary channel:** Slack
- **Response style:** Quick to respond, appreciates direct feedback

## Career Context

Interested in Director track. Has mentioned wanting more exposure to business stakeholders.

## Recent Topics

<!-- Updated after 1:1s -->

| Date | Topics | Follow-ups |
|------|--------|------------|

## Notes

<!-- Observations added over time -->
```

---

## Stakeholder Template

**Location:** `people/stakeholders/{slug}.md`

```markdown
# {name}

**Role:** {role}
**Relationship:** {relationship_type}

## Interaction Context

{what_we_interact_about}

## Communication Preferences

- **Channel:** {preferred_channel}
- **Style:** {style_notes}
- **Frequency:** {interaction_frequency}

## Key Concerns

{what_they_care_about}

## Notes

<!-- Observations added over time -->
```

### Field Mapping

| Answer Field | Template Field |
|--------------|----------------|
| `Stakeholders > {name} > Name` | `{name}` |
| `Stakeholders > {name} > Role` | `{role}` |
| `Stakeholders > {name} > Relationship` | `{relationship_type}` |
| `Stakeholders > {name} > Interact about` | `{what_we_interact_about}` |
| `Stakeholders > {name} > Communication preferences` | `{preferred_channel}`, `{style_notes}` |

### Example Output

```markdown
# Amanda Liu

**Role:** VP Product
**Relationship:** Peer / Cross-functional partner

## Interaction Context

Roadmap planning, feature prioritisation, engineering capacity allocation.
Joint ownership of product delivery metrics.

## Communication Preferences

- **Channel:** Slack for quick items, meetings for decisions
- **Style:** Appreciates data-driven arguments, visual aids
- **Frequency:** Weekly roadmap sync, ad-hoc as needed

## Key Concerns

- Feature delivery timelines
- Technical feasibility early in planning
- Customer-facing quality

## Notes

<!-- Observations added over time -->
```

---

## Generation Process

For each person captured in onboarding:

1. **Determine type:** Manager, Direct Report, or Stakeholder
2. **Generate slug:** `lowercase-hyphenated-name`
3. **Select template:** Based on type
4. **Populate fields:** Map from answers.md
5. **Write file:** To appropriate location
6. **Seed memory:** Create corresponding memory entity (see memory-seed.md)

## Verification Checklist

After generating person files:

- [ ] `people/manager.md` exists (unless N/A)
- [ ] One file per direct report in `people/team/`
- [ ] One file per key stakeholder in `people/stakeholders/`
- [ ] All files have name and role populated
- [ ] Files use consistent slug format
- [ ] Notes section present for future observations

## Edge Cases

### Missing Data

If optional fields are missing, use placeholder:
```markdown
## Communication Preferences

- **Channel:** Not yet captured
- **Style:** To be determined
```

### Duplicate Names

If two people have the same name:
- First: `john-smith.md`
- Second: `john-smith-product.md` (append role slug)

### Very Long Names

Truncate slug at 30 characters:
- "Alexandra Elizabeth Montgomery-Worthington" → `alexandra-elizabeth-montgomer`
