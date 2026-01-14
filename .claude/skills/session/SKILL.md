---
name: session
description: Context management across sessions. Use at session start (/resume) to restore context, and before ending (/preserve) to capture state for continuity. Also handles session handoffs and context summaries.
user-invocable: true
---

# Session Management

## Purpose

Maintain continuity across conversation sessions. Claude Code sessions can end abruptly (timeout, user closes terminal, context limit). This skill ensures critical context is preserved and restored, making each session feel like a continuation rather than a fresh start.

## Data Locations

- `work/actions.md` - Current action items (always check at session start)
- `reference/system/patterns.md` - Learned patterns to apply
- Memory graph - Persistent knowledge and improvement observations

## Workflows

### Resume (/resume)

**When:** Start of a new session, or explicitly requested with `/resume`

**Input:**
- Memory graph (query for recent observations, pending improvements)
- `work/actions.md` (current state)
- Previous session context (if available in memory)

**Process:**
1. Query memory graph for:
   - Any improvement entities with 3+ observations (surface if appropriate)
   - Recent observations about ongoing work
   - Any "session-handoff" entities from previous session
2. Read `work/actions.md` for current priorities
3. Check for any urgent/overdue items
4. Synthesise brief context summary
5. Present to user without being verbose

**Output:**
Brief, scannable status:
```
Welcome back. Quick context:

**In flight:** {1-2 key items from previous session if any}
**Priority actions:** {top 2-3 from actions.md}
**Heads up:** {anything time-sensitive or noteworthy}

What would you like to focus on?
```

**Verification:**
- [ ] Memory graph queried for recent context
- [ ] Actions.md checked for priorities
- [ ] Output is brief (under 100 words)
- [ ] User can immediately start working

**Next:** User directs session focus

---

### Preserve (/preserve)

**When:** Before ending a session, especially if work is in progress. User says `/preserve` or indicates they're leaving.

**Input:**
- Current conversation context
- Any in-progress work
- Decisions made this session
- Open questions or next steps

**Process:**
1. Identify key context to preserve:
   - What was being worked on
   - Decisions made and rationale
   - Open questions or blockers
   - Suggested next steps
2. Create session-handoff entity in memory graph:
   ```
   Entity: session-handoff-{date}
   Type: session
   Observations:
     - "Working on: {description}"
     - "Decided: {key decisions}"
     - "Open: {questions/blockers}"
     - "Next: {suggested actions}"
   ```
3. Update `work/actions.md` if new items emerged
4. Confirm preservation to user

**Output:**
```
Context preserved for next session:
- {brief summary of what's saved}

Your actions.md is up to date. See you next time.
```

**Verification:**
- [ ] Session-handoff entity created in memory
- [ ] In-progress work documented
- [ ] Any new actions added to actions.md
- [ ] User confirmed context is captured

**Next:** Session ends, context available for next `/resume`

---

### Handoff

**When:** Explicitly handing off to another session or context (e.g., different device, shared with colleague)

**Input:**
- What to hand off
- Who/what is receiving the handoff
- Any special context needed

**Process:**
1. Gather all relevant context for the handoff
2. Create comprehensive summary document
3. Include:
   - Current state
   - Key decisions and rationale
   - Open items and owners
   - Relevant file locations
   - Any gotchas or context the receiver needs
4. Format for the recipient (human vs AI)

**Output:**
Standalone handoff document that provides full context without needing conversation history.

**Verification:**
- [ ] Recipient can understand state without prior context
- [ ] All relevant files/locations referenced
- [ ] Open items clearly marked
- [ ] No assumed knowledge

**Next:** Share with recipient

---

### Context Summary

**When:** User asks "where are we?" or "what's the current state?" mid-session

**Input:**
- Current conversation
- Recent work in this session

**Process:**
1. Summarise current session's focus
2. List key decisions/progress made
3. Note any open threads
4. Keep it brief and actionable

**Output:**
```
**This session:**
- {main focus}
- {key progress/decisions}

**Open threads:**
- {thing 1}
- {thing 2}

**Next up:** {what we were about to do}
```

**Verification:**
- [ ] Summary is accurate to session
- [ ] User can reorient quickly
- [ ] Open items captured

**Next:** Continue with work

## Related Files

- `work/actions.md` - Always synced with session state
- `reference/system/improvements.md` - Session may surface improvements
- Memory graph - Primary persistence layer

## Best Practices

- **Don't over-preserve:** Only capture what's genuinely useful for continuity
- **Be brief on resume:** User wants to work, not read a novel
- **Update actions.md incrementally:** Don't wait for session end
- **Use memory wisely:** Session-handoff entities are temporary; delete after successful resume
- **Respect urgency:** If user is clearly in a hurry, skip the ceremony
