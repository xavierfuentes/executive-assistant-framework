---
name: generate
description: Generate command centre from onboarding answers. Use after completing onboarding to create CLAUDE.md, skills, people files, and seed memory graph. Invoke with target directory path.
user-invocable: true
---

# Generate Command Centre

## Purpose

Transform completed onboarding answers into a fully functional command centre. This skill reads the answers captured during onboarding and creates all necessary files, skills, and memory entities.

## Data Locations

- `.claude/bootstrap/answers.md` - Input (completed onboarding answers)
- `.claude/bootstrap/generators/` - Generator templates for reference
- Target directory - Output location (specified as parameter)

## Workflows

### Generate

**When:** After onboarding Phase 7 confirmation, or when user says "generate my command centre"

**Input:**
- Completed `.claude/bootstrap/answers.md`
- Target directory path (default: `./generated/`)
- Optional: `--force` flag to overwrite existing files

**Process:**

#### Step 1: Validate Input

1. Check `.claude/bootstrap/answers.md` exists
2. Verify required sections present:
   - Identity (name, title, company, timezone)
   - Responsibilities (at least one with priority: initial)
   - Preferences (communication section)
3. If validation fails, report missing sections and stop

**Report:** "Validating answers.md... ✓ Found {n} responsibilities, {m} people"

#### Step 2: Create Directory Structure

Read `.claude/bootstrap/generators/structure.md` for reference.

Create in target directory:
```
{target}/
├── people/
│   ├── team/
│   └── stakeholders/
├── work/
│   └── transcriptions/
├── reference/
│   ├── company/
│   ├── process/
│   ├── guides/
│   └── system/
├── me/
└── .claude/
    ├── skills/
    ├── agents/
    └── hooks/
```

**Report:** "Creating directory structure... ✓"

#### Step 3: Generate Template Files

Create these files from structure.md templates:

| File | Content |
|------|---------|
| `{target}/work/actions.md` | Eisenhower matrix template |
| `{target}/reference/system/improvements.md` | Improvements log template |
| `{target}/reference/system/patterns.md` | Patterns template |
| `{target}/reference/company/overview.md` | Company context (populated from answers) |

**Report:** "Creating template files... ✓"

#### Step 4: Generate CLAUDE.md

Read `.claude/bootstrap/generators/claude-md.md` for transformation logic.

Extract from answers.md:
- Identity → Header and "Who You're Helping" section
- Preferences → Communication Style and Rules sections
- Responsibilities → Role Overview and Skills table
- Self-awareness → Reminders and Never rules

Include full self-improvement protocol from template.

Write to: `{target}/CLAUDE.md`

**Report:** "Generating CLAUDE.md... ✓"

#### Step 5: Generate People Files

Read `.claude/bootstrap/generators/person.md` for templates.

For each person in answers.md:

| Person Type | Template | Output Location |
|-------------|----------|-----------------|
| Manager | Manager template | `{target}/people/manager.md` |
| Direct Report | Direct Report template | `{target}/people/team/{slug}.md` |
| Stakeholder | Stakeholder template | `{target}/people/stakeholders/{slug}.md` |

Slug generation: lowercase, hyphenate spaces, remove special characters.

**Report:** "Generating people files... ✓ Created {n} profiles"

#### Step 6: Validate and Generate Skills

Read `.claude/bootstrap/generators/skill.md` for transformation logic.

**6.1 Pre-validation (for each responsibility with priority: initial)**

Before generating any files, validate:

a) **Description Quality Check**
   - Draft description using formula: "{responsibility_name}. Use for {task_1}, {task_2}, {task_3}, and {success_metric} tracking."
   - Validate:
     - [ ] Length >= 50 characters
     - [ ] Length <= 1024 characters
     - [ ] Contains "Use for" or "Use when" trigger section
     - [ ] Lists 3-8 specific trigger activities
     - [ ] No banned vague terms ("things", "stuff", "various", "etc.")
   - If validation fails: queue for clarification

b) **Success Criteria Check**
   - Score 0-3:
     - 0: Pure subjective ("do it well") → REJECT
     - 1: Intent without metric ("good retention") → FLAG
     - 2: Has metric or concrete outcome → ACCEPT
     - 3: Metric + timeframe + threshold → IDEAL
   - If score 0: queue for clarification
   - If score 1: add to warnings, proceed with flag

c) **Size Estimation**
   - Estimate: 50 + (workflow_count * 35) + (collaborator_count * 2) + 20
     (See `.claude/bootstrap/generators/skill.md` > Validation Rules > Size Limit Enforcement for formula details)
   - If > 450: add warning
   - If > 600: queue for user decision

**6.2 Clarification (if needed)**

For each queued item, ask user for specific improvement.

**Clarification Loop Protocol:**

- **Maximum attempts:** 3 per item
- **On each attempt:** Present specific validation failure, await user response
- **Valid responses:** Improved criteria OR "skip" to defer

**On Clarification Failure (after 3 attempts):**

Offer options:
```
I've tried {n} times to get valid criteria for "{responsibility}".

Options:
1. **Skip this skill for now** - Queue for later when you have clearer criteria
2. **Generate with defaults** - Create basic skill with generic criteria (refine later)
3. **Try once more** - Provide new criteria

Which would you prefer?
```

- **If skip:** Add to "Queued Responsibilities" in answers.md, continue with remaining
- **If defaults:** Use "Effective {responsibility} management, measured by stakeholder feedback", set score=1 (flagged), add warning to generated skill
- **If try once more:** Reset attempts to 1 (allowed once per responsibility)

**6.3 Generate Skills**

For each validated responsibility:
1. Generate slug from responsibility name
2. Create description field (use the description that passed validation in Step 6.1a, or the user-provided improvement from Step 6.2)
3. Extract purpose from validated success criteria
4. Map data tracked to data locations
5. Transform recurring tasks into workflows
6. Add related files linking to people
7. Generate domain-appropriate best practices
8. **Post-generation size check:** If > 500 lines, auto-split to reference.md

Write to: `{target}/.claude/skills/{slug}/SKILL.md`

**Report:** "Generating skills... ✓ Created {n} skills: {list}"

#### Step 7: Seed Memory Graph

Read `.claude/bootstrap/generators/memory-seed.md` for entity structure.

Create entities using MCP memory tools:

1. **User entity:**
   ```
   mcp__memory__create_entities([{
     name: "{user-slug}",
     entityType: "user",
     observations: ["Role: {title} at {company}", "Timezone: {timezone}", ...]
   }])
   ```

2. **Person entities** (manager, reports, stakeholders):
   ```
   mcp__memory__create_entities([{
     name: "{person-slug}",
     entityType: "person",
     observations: ["Role: {role}", "Profile: {profile_path}", ...]
   }])
   ```

3. **Relationships (bidirectional for reporting lines):**
   ```
   mcp__memory__create_relations([
     // Manager relationship (both directions)
     {from: "{user}", to: "{manager}", relationType: "reports-to"},
     {from: "{manager}", to: "{user}", relationType: "manages"},

     // Direct report relationships (both directions)
     {from: "{report}", to: "{user}", relationType: "reports-to"},
     {from: "{user}", to: "{report}", relationType: "manages"},

     // Peer relationships (single direction, symmetric)
     {from: "{user}", to: "{peer}", relationType: "works-with"}
   ])
   ```

**Error Handling - Retry with Backoff:**

If memory seeding fails, implement retry logic:

```
attempt = 1
max_attempts = 3
backoff_ms = [1000, 2000, 4000]

while attempt <= max_attempts:
  try:
    seed_memory_entities()
    break
  catch error:
    log_error(attempt, error)
    if attempt < max_attempts:
      wait(backoff_ms[attempt - 1])
      attempt += 1
    else:
      handle_memory_failure()
```

**On Permanent Failure (after 3 attempts):**

1. **Skip memory seeding** - Do not block generation
2. **Set flag:** `memory_seeding_failed = true` (used in health check)
3. **Add remediation task to actions.md:**
   ```markdown
   ## Urgent & Important

   - [ ] **Seed memory graph** - Memory server was unavailable during generation.

         **To retry automatically:**
         Say: "retry memory seeding" - I'll re-run the memory seeding step

         **To seed manually (if automatic retry fails):**
         1. Ensure MCP memory server is running
         2. Use the commands in `.claude/bootstrap/pending-memory-seed.json`
   ```

4. **Store seeding data for retry:**
   Write to `{target}/.claude/bootstrap/pending-memory-seed.json`:
   ```json
   {
     "created": "{timestamp}",
     "reason": "{error_message}",
     "entities": [{entity_objects}],
     "relations": [{relation_objects}]
   }
   ```

5. **Log to generation report:**
   ```
   ⚠ Memory seeding skipped - MCP server unavailable
     Remediation task added to actions.md
   ```
6. **Continue with remaining steps** - Generation should complete successfully

**Partial Failure Handling:**

Memory seeding happens in two phases: entities, then relationships.

| Entities | Relations | Action |
|----------|-----------|--------|
| All succeed | All succeed | Report success |
| All succeed | Some fail | Warn + add relation remediation task |
| All succeed | All fail | Warn + add full relationship remediation |
| Some fail | Any | Warn + skip relations for failed entities + add remediation |
| All fail | N/A | Use full failure logic above |

**On Partial Failure:**
1. Set `memory_seeding_partial = true`
2. Store failed items in `pending-memory-seed.json`
3. Add warning to generation report
4. Continue with Step 8 (non-blocking)

**Report (success):** "Seeding memory graph... ✓ Created {n} entities, {m} relationships"

**Report (failure):** "Seeding memory graph... ⚠ Skipped (server unavailable) - remediation task added"

#### Step 8: Copy Universal Components

Copy from framework to target:

**Skills:**
- `.claude/skills/session/SKILL.md` → `{target}/.claude/skills/session/SKILL.md`
- `.claude/skills/humanize/SKILL.md` → `{target}/.claude/skills/humanize/SKILL.md`

**Agents:**
- `.claude/agents/weekly-prep.md` → `{target}/.claude/agents/weekly-prep.md`
- `.claude/agents/health-check.md` → `{target}/.claude/agents/health-check.md`

**Hooks:**
- `.claude/hooks/check-actions.sh` → `{target}/.claude/hooks/check-actions.sh`
- `.claude/hooks/check-memory.sh` → `{target}/.claude/hooks/check-memory.sh`

Make hooks executable: `chmod +x {target}/.claude/hooks/*.sh`

**Settings:**
Create `{target}/.claude/settings.json` with hook configuration from structure.md.

**Report:** "Copying universal components... ✓"

#### Step 9: Health Check

Verify generation succeeded:

**Required checks (must pass):**
- [ ] All directories exist
- [ ] CLAUDE.md has correct header format
- [ ] People count matches answers.md
- [ ] Skill count matches priority responsibilities
- [ ] Hooks are executable
- [ ] No broken file references in skills

**Conditional checks (adapt to memory state):**
- [ ] Memory entities queryable - **Skip if `memory_seeding_failed` flag is set**

**Memory verification logic:**

```
expected_entities = 1 + people_count  // user + all people
expected_relations = calculate_expected_relations()
// 2 per manager (0 if user has no manager), 2 per report, 2 per peer, 2 per collaborator

**Edge case - No manager:**
If user has no manager (e.g., CEO/founder), expected manager relations = 0.
The health check should not fail for missing manager relationships in this case.

if memory_seeding_failed:
  skip all memory checks
  add warning: "Memory checks skipped - seeding was deferred"

else if memory_seeding_partial:
  actual_entities = query_entity_count()
  actual_relations = query_relation_count()
  add warning: "Memory partially seeded: {actual}/{expected} entities, {actual}/{expected} relationships"

else:
  actual_entities = query_entity_count()
  actual_relations = query_relation_count()

  if actual_entities != expected_entities:
    add warning: "Entity count mismatch: expected {expected}, got {actual}"

  if actual_relations != expected_relations:
    add warning: "Relationship count mismatch: expected {expected}, got {actual}"

  // Verify critical entities exist
  verify user_slug and manager_slug exist
```

**Report (all pass):** "Running health check... ✓ All {n} checks passed"

**Report (with warnings):** "Running health check... ✓ {n} checks passed, {m} warnings"

**Output:**

```
═══════════════════════════════════════════════════════
  Command Centre Generated Successfully
═══════════════════════════════════════════════════════

  Location: {target}/

  Created:
  • CLAUDE.md (personalised instructions)
  • {n} people profiles
  • {m} skills with workflows
  • {p} memory entities
  • Universal skills (session, humanize)
  • Agents (weekly-prep, health-check)
  • Hooks (check-actions, check-memory)

  Next steps:
  1. Review CLAUDE.md and adjust any rules
  2. Run /resume to start your first session
  3. The system will learn and improve as you use it

═══════════════════════════════════════════════════════
```

**Verification:**
- [ ] No errors during generation (warnings acceptable)
- [ ] All expected files created
- [ ] Memory graph populated OR remediation task added to actions.md
- [ ] Health check passed (with or without warnings)

**Next:** User reviews generated files and begins using their command centre

---

### Validate

**When:** User wants to check answers.md before generating

**Input:**
- `.claude/bootstrap/answers.md`

**Process:**
1. Check file exists
2. Parse sections
3. Report completeness
4. Flag any issues

**Output:**
```
Answers Validation Report
─────────────────────────
Identity:     ✓ Complete
Responsibilities: ✓ {n} found ({m} marked initial)
People:       ✓ Manager + {x} reports + {y} stakeholders
Cadence:      ✓ {z} meetings defined
Preferences:  ⚠ Missing: blind spots

Ready to generate: Yes (with warnings)
```

**Verification:**
- [ ] All required sections checked
- [ ] Warnings clearly explained

---

### Resume

**When:** Generation was interrupted and user wants to continue

**Input:**
- Target directory with partial generation
- `.claude/bootstrap/answers.md`

**Process:**
1. Scan target directory for existing files
2. Determine what's missing
3. Continue from where it stopped
4. Skip already-created files

**Output:**
Report of what was resumed and completed.

**Verification:**
- [ ] No duplicate files created
- [ ] Partial work preserved

## Related Files

- `.claude/bootstrap/generators/` - All generator templates
- `.claude/bootstrap/answers.md` - Input data
- `.claude/bootstrap/onboarding.md` - Onboarding workflow reference

## Best Practices

- **Always validate first** - Run validate workflow before generate if unsure
- **Use sandbox for testing** - Generate to `./sandbox/` first to inspect output
- **Don't skip health check** - It catches issues before user starts working
- **Report progress** - Users like seeing each step complete
- **Preserve existing work** - Never overwrite without explicit --force flag
