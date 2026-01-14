---
name: health-check
description: Pre-meeting status dashboard. Run before important meetings to get a quick snapshot of relevant context, open items, and talking points.
hooks:
  Stop:
    - type: prompt
      prompt: |
        Before stopping health check, verify:
        1. Meeting context has been identified
        2. Relevant open items surfaced
        3. Key people context loaded if applicable
        4. Output is concise and actionable
        Respond with JSON: {"decision": "stop"} or {"decision": "continue", "reason": "..."}
---

# Health Check

## Purpose

Provide rapid context before important meetings. Instead of scrambling to remember what's relevant, get a focused brief with exactly what you need: attendee context, relevant open items, potential topics, and any recent developments.

## When to Run

- Before important meetings (leadership, board, key stakeholders)
- Before 1:1s (especially if irregular or with someone you don't see often)
- When user asks "what do I need to know for [meeting]?"
- Before presenting or making decisions

## Execution

This agent runs the following in parallel, filtered by meeting context:

### 1. Meeting Context
**Input:** Meeting details (who, what, when)

- Identify meeting type and purpose
- Determine relevant responsibility areas
- Set scope for other checks

### 2. People Lookup
**Source:** `people/`, memory graph

For each attendee:
- Pull profile summary
- Check recent observations in memory
- Note last interaction and any follow-ups
- Surface any relationship context

### 3. Relevant Actions
**Source:** `work/actions.md`

- Filter actions relevant to meeting topic/attendees
- Surface any items that should be raised
- Note anything overdue that may come up
- Check delegated items if meeting with delegates

### 4. Responsibility Context
**Source:** Relevant skill files

Based on meeting topic:
- Pull current state of relevant area
- Note recent progress or blockers
- Identify data points that might be asked about

### 5. Recent Developments
**Source:** Memory graph, recent session context

- Anything new since last similar meeting?
- Decisions made that should be communicated?
- Changes in situation?

## Output

Concise meeting brief:

```markdown
# Health Check: {Meeting Name}
{date/time}

## Attendees
{For each person, 1-2 line summary with relevant context}

- **{Name}** ({role}): {recent context, what they care about}

## Relevant Open Items
- {item relevant to this meeting}
- {item relevant to this meeting}

## Potential Topics
Based on context, you might discuss:
- {topic_1}
- {topic_2}

## Recent Developments
- {anything new since last meeting}

## Heads Up
- {anything to be aware of - risks, sensitivities, opportunities}
```

## Output Variants

### For 1:1 with Direct Report

```markdown
# 1:1 Prep: {Name}
{date/time}

## Current Context
- **Focus:** {their current priorities}
- **Development:** {areas they're working on}
- **Last 1:1:** {date} - {key topics}

## Their Open Items
{actions they own or are waiting on}

## Your Topics
- {things to discuss with them}

## Follow-ups from Last Time
- {anything you committed to}

## Notes
{anything from their profile worth remembering}
```

### For Leadership/Board Meeting

```markdown
# Leadership Prep: {Meeting Name}
{date/time}

## Your Updates
{what you should report on}

## Current Metrics
{key numbers for your areas}

## Open Items for This Forum
- {decisions needed}
- {escalations}

## Potential Questions
{what you might be asked}

## Context on Others' Topics
{if agenda known, context on other items}
```

## Verification

Before completing:

- [ ] All attendees identified with context
- [ ] Relevant actions surfaced (not all actions)
- [ ] Output fits meeting type
- [ ] Brief enough to scan in 2 minutes
- [ ] Actionable (not just informational)

## Integration

After health check:
- Offer to draft talking points
- Offer to pull specific data
- Note to capture outcomes after meeting

## Customisation

Adapts based on:
- **Meeting type:** 1:1 vs group vs external
- **Attendee relationship:** Report, peer, senior, external
- **Formality:** Leadership meeting vs casual sync
- **User preferences:** Some want detailed, some want minimal
