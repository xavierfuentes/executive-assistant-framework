# Calibration Flow

Post-setup refinement for adjusting the command centre after initial generation.

## Purpose

The initial generation is based on onboarding answers, but reality is messy. Users will want to:
- Correct misunderstandings
- Add missing information
- Adjust generated content
- Expand the system over time

This flow handles those adjustments without requiring full regeneration.

---

## When to Use

| Trigger | Action |
|---------|--------|
| "This isn't quite right" | Targeted update |
| "I forgot to mention..." | Add new entity |
| "Can we change..." | Modify existing |
| "Remove this..." | Delete with cleanup |
| First week of use | Proactive review |

---

## Calibration Types

### 1. Identity Corrections

**Trigger:** User says name/title/company is wrong

**Process:**
1. Ask what's incorrect
2. Update `answers.md` with correction
3. Update `CLAUDE.md` header
4. Update user entity in memory graph
5. Confirm changes

**Files touched:**
- `.claude/bootstrap/answers.md`
- `CLAUDE.md`
- Memory graph (user entity)

---

### 2. Responsibility Adjustments

#### Add New Responsibility

**Trigger:** "I also handle X" or "Add a skill for Y"

**Process:**
1. Gather responsibility details (same questions as onboarding Phase 3):
   - What is it called?
   - What does success look like?
   - Who do you collaborate with?
   - What data do you track?
   - What recurring tasks?
2. Determine priority (initial or queued)
3. If initial: generate skill immediately
4. Update `answers.md` with new responsibility
5. Update `CLAUDE.md` skills table
6. Confirm addition

**Files touched:**
- `.claude/bootstrap/answers.md`
- `CLAUDE.md` (skills table)
- `.claude/skills/{new-slug}/SKILL.md` (if initial priority)

#### Modify Existing Responsibility

**Trigger:** "Update the hiring skill" or "Change success criteria for X"

**Process:**
1. Read current skill file
2. Ask what needs changing
3. Update skill file with changes
4. Update `answers.md` to match
5. Confirm changes

**Files touched:**
- `.claude/skills/{slug}/SKILL.md`
- `.claude/bootstrap/answers.md`

#### Remove Responsibility

**Trigger:** "I no longer handle X" or "Remove the Y skill"

**Process:**
1. Confirm removal
2. Delete skill directory
3. Update `CLAUDE.md` skills table
4. Update `answers.md`
5. Note: Don't delete related data files (may have historical value)

**Files touched:**
- `.claude/skills/{slug}/` (deleted)
- `CLAUDE.md`
- `.claude/bootstrap/answers.md`

---

### 3. People Updates

#### Add Person

**Trigger:** "Add Sarah to my team" or "New stakeholder: X"

**Process:**
1. Determine person type (report, stakeholder)
2. Gather details (same as onboarding Phase 4)
3. Create profile file
4. Create memory entity
5. Create relationships
6. Update `answers.md`
7. Update relevant skill "Related Files" sections

**Files touched:**
- `people/team/{slug}.md` or `people/stakeholders/{slug}.md`
- `.claude/bootstrap/answers.md`
- Memory graph
- Potentially `.claude/skills/*/SKILL.md` (Related Files)

#### Update Person

**Trigger:** "Update Sarah's profile" or "Sarah got promoted"

**Process:**
1. Read current profile
2. Ask what changed
3. Update profile file
4. Add observation to memory entity
5. Update `answers.md` if structural change

**Files touched:**
- `people/*/{slug}.md`
- Memory graph (add observation)
- `.claude/bootstrap/answers.md` (if role change)

#### Remove Person

**Trigger:** "Remove Sarah" or "X left the company"

**Process:**
1. Confirm removal
2. Archive profile (move to `people/archive/`) rather than delete
3. Update memory entity with departure observation
4. Update `answers.md`
5. Update skill "Related Files" sections

**Files touched:**
- `people/*/{slug}.md` (moved to archive)
- Memory graph (departure observation)
- `.claude/bootstrap/answers.md`
- Potentially `.claude/skills/*/SKILL.md`

---

### 4. Preference Changes

**Trigger:** "Change my communication style" or "Update my working hours"

**Process:**
1. Ask what's changing
2. Update `CLAUDE.md` relevant section
3. Update `answers.md` preferences
4. Update `reference/system/patterns.md` if style-related
5. Confirm changes

**Files touched:**
- `CLAUDE.md`
- `.claude/bootstrap/answers.md`
- `reference/system/patterns.md` (if style change)

---

### 5. Workflow Refinement

**Trigger:** "The weekly pipeline review workflow isn't quite right"

**Process:**
1. Read current workflow in skill file
2. Ask what needs adjustment:
   - Different trigger/timing?
   - Different inputs needed?
   - Process steps wrong?
   - Output format change?
   - Verification criteria update?
3. Update workflow in skill file
4. Confirm changes

**Files touched:**
- `.claude/skills/{slug}/SKILL.md`

---

### 6. Add Missing Workflow

**Trigger:** "I need a workflow for X" or organic discovery (3+ manual repetitions)

**Process:**
1. Identify which skill it belongs to (or create new skill)
2. Gather workflow details:
   - When should it trigger?
   - What inputs are needed?
   - What are the steps?
   - What's the output format?
   - How do we verify success?
3. Add workflow to skill file
4. If from organic discovery, mark improvement as implemented in memory

**Files touched:**
- `.claude/skills/{slug}/SKILL.md`
- Memory graph (if from organic discovery)
- `reference/system/improvements.md` (if from organic discovery)

---

## Proactive Calibration (First Week)

After initial generation, proactively offer calibration at natural points:

### Day 2-3: Quick Check
```
You've been using the command centre for a couple of days.
Anything feel off or missing so far?

Common adjustments:
- Skill descriptions not triggering correctly
- Missing people or responsibilities
- Preference tweaks
```

### Day 5-7: Deeper Review
```
End of first week. Let's review:

1. **Skills used:** {list}
   - Any that didn't work as expected?

2. **Skills not used:** {list}
   - Are these relevant, or should we adjust/remove?

3. **Manual work I noticed:**
   - {any repeated manual tasks}
   - Should these become workflows?

4. **People mentioned without profiles:**
   - {list}
   - Want to add any of these?
```

---

## Calibration Principles

1. **Preserve history** - Archive rather than delete when possible
2. **Update source** - Always update `answers.md` so regeneration works
3. **Sync memory** - Keep memory graph in sync with files
4. **Minimal disruption** - Change only what's needed
5. **Confirm changes** - Always verify with user before writing

---

## Quick Reference

| User says | Action |
|-----------|--------|
| "Fix the X skill" | Modify responsibility |
| "Add Y to my team" | Add person |
| "I also handle Z" | Add responsibility |
| "Remove the W skill" | Remove responsibility |
| "Update my preferences" | Preference change |
| "This workflow is wrong" | Workflow refinement |
| "I do this manually a lot" | Add missing workflow |
| "Person X left" | Remove person |
| "Actually my title is..." | Identity correction |
