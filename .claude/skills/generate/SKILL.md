---
name: generate
description: Generate command centre from onboarding answers. Use after completing onboarding to create CLAUDE.md, skills, people files, and seed memory graph. Invoke with target directory path.
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

#### Step 6: Generate Skills

Read `.claude/bootstrap/generators/skill.md` for transformation logic.

For each responsibility with `priority: initial`:

1. Generate slug from responsibility name
2. Create description field (critical for auto-discovery)
3. Extract purpose from success criteria
4. Map data tracked to data locations
5. Transform recurring tasks into workflows
6. Add related files linking to people
7. Generate domain-appropriate best practices

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

3. **Relationships:**
   ```
   mcp__memory__create_relations([
     {from: "{user}", to: "{manager}", relationType: "reports-to"},
     {from: "{report}", to: "{user}", relationType: "reports-to"},
     {from: "{user}", to: "{peer}", relationType: "works-with"}
   ])
   ```

**Report:** "Seeding memory graph... ✓ Created {n} entities, {m} relationships"

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

- [ ] All directories exist
- [ ] CLAUDE.md has correct header format
- [ ] People count matches answers.md
- [ ] Skill count matches priority responsibilities
- [ ] Memory entities queryable
- [ ] Hooks are executable
- [ ] No broken file references in skills

**Report:** "Running health check... ✓ All {n} checks passed"

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
- [ ] No errors during generation
- [ ] All expected files created
- [ ] Memory graph populated
- [ ] Health check passed

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
