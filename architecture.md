# Executive Assistant Framework - Architecture

  ## Vision

  A self-bootstrapping AI command centre that any executive can configure through conversation. It asks questions, builds its own structure, and continuously improves.

  ---

  ## Project Structure (Target)

  executive-assistant/
  ├── CLAUDE.md                     # Generated from onboarding
  ├── README.md                     # Auto-generated architecture guide
  │
  ├── .claude/
  │   ├── skills/                   # Domain containers (generated from role)
  │   │   └── {skill}/
  │   │       ├── SKILL.md          # Skill overview, workflows inline, data locations
  │   │       ├── reference.md      # Optional: detailed docs (progressive disclosure)
  │   │       └── scripts/          # Optional: helper scripts
  │   ├── agents/                   # Cross-domain orchestrators
  │   ├── hooks/                    # Consistency automation scripts
  │   ├── memory.jsonl              # Knowledge graph (MCP)
  │   ├── settings.json             # Hook configuration
  │   └── bootstrap/                # Onboarding system
  │       ├── onboarding.md         # Workflow: document collection → extraction → gap-fill
  │       ├── answers-template.md   # Markdown structure for captured data
  │       ├── mapping.md            # Source field → generated output relationships
  │       ├── extraction-prompts.md # Prompts for CV/JD/LinkedIn parsing
  │       └── generators/           # Code that creates skills (future)
  │
  ├── people/                       # Relationships (universal)
  │   ├── team/                     # Direct reports
  │   ├── stakeholders/             # Key relationships
  │   └── manager.md                # Reporting line
  │
  ├── work/                         # Task tracking (universal)
  │   ├── actions.md                # Eisenhower matrix
  │   ├── risks.md                  # Risk register
  │   └── transcriptions/           # Meeting notes
  │
  ├── reference/                    # Context & guides
  │   ├── company/                  # Organisation context
  │   ├── process/                  # How the user works
  │   ├── guides/                   # Frameworks, style guides
  │   └── system/                   # Self-improvement data
  │       ├── improvements.md       # Implemented improvements log
  │       └── patterns.md           # Anti-patterns + learnings
  │
  └── me/                           # User's personal files

  ---

  ## Core Concepts

  ### Skills
  Domain expertise containers. Each skill has:
  - **SKILL.md** - Metadata, purpose, data locations, **workflows inline**
  - **reference.md** - Optional detailed docs Claude loads on-demand
  - **scripts/** - Optional helper scripts

  Skills are auto-discovered based on their `description` field (not name). The description is CRITICAL - it determines when Claude uses the skill.

  **Size limit:** Keep SKILL.md under 500 lines. Move detailed content to reference.md.

  ### Workflows (Inline)
  Workflows are sections within SKILL.md, not separate files. Each workflow includes:
  - **When** - Specific trigger for this workflow
  - **Input** - What data/parameters needed
  - **Process** - Numbered steps
  - **Output** - Template with placeholders
  - **Verification** - Observable checklist (not "looks good" but "X scored Y/N")
  - **Next** - What happens after

  ### Agents
  Cross-domain orchestrators that run multiple skills in parallel. Used for:
  - Weekly preparation (aggregate across all domains)
  - Health checks (status dashboard before meetings)
  - Complex tasks requiring multiple skill areas

  ### Hooks
  Bash scripts that fire on tool use (PostToolUse, PreToolUse). Used for:
  - Reminding to update actions.md after writing to people/work files
  - Reminding to update memory graph after updating person profiles
  - Warning before modifying sensitive files

  Hooks REMIND, never BLOCK. They exit 0 and echo suggestions.

  ### Memory (Knowledge Graph)
  MCP server storing entities and relationships:
  - People (team, stakeholders, manager)
  - Relationships with explicit directionality:
    - `reports-to` (subordinate → superior)
    - `manages` (superior → subordinate) - inverse of reports-to
    - `works-with` (peer ↔ peer) - symmetric (stored bidirectionally)
    - `collaborates-with` (person ↔ collaborator) - responsibility-specific partnerships
  - Observations (facts learned over time)

  **Bidirectional Rule:** All relationships require BOTH directions stored explicitly:
  - Reporting: `reports-to` AND `manages`
  - Peers: `works-with` in both directions
  - Collaborators: `collaborates-with` in both directions

  **Entity Naming:** lowercase, hyphenated, max 50 chars. Pattern: `^[a-z][a-z0-9-]{0,48}[a-z0-9]?$`

  **Cleanup:** Improvement entities archived to `reference/system/improvements.md` after 30 days, then deleted via `mcp__memory__delete_entities`.

  ### Self-Improvement (Organic)
Not a skill to invoke - a behavioural layer woven into CLAUDE.md.

**Observe (continuous):** During all work, notice repeated manual operations, missing data, corrections, friction, gaps. Log to memory graph entity `improve-{slug}` without interrupting user.

**Surface (contextual):** Propose improvements when doing the thing again with 3+ prior observations, or at natural pauses. Be specific: "I've done X manually 5 times - shall I create a workflow?"

**Implement (on approval):** Create/update the relevant file, mark entity as implemented, continue.

**Boundaries:**
- Never propose during first 5 sessions (establish baseline)
- Never interrupt urgent work
- Maximum 1 proposal per session unless asked
- If declined 2x, stop proposing that specific improvement

Implemented improvements archived to `reference/system/improvements.md` after 30 days.

  ---

  ## Onboarding Flow

Document-first approach: extract from existing materials, confirm, then fill gaps.

### Phase 0: Document Collection
User provides any available:
- CV/resume
- Job description (or similar)
- Company overview
- Org chart (screenshot or description)
- LinkedIn profiles for key people (screenshots/PDFs)

### Phase 1: Extraction & Confirmation
- Run extraction prompts on provided documents
- Present extracted data for user confirmation
- Correct any errors before proceeding

### Phase 2: Gap-Filling - Identity
Only ask if not extracted:
- Name, title, company, timezone
- Reporting line (manager name and title)

### Phase 3: Gap-Filling - Responsibilities
If job description provided:
- Confirm extracted responsibilities
- User selects top 5-7 for initial skill generation
- Remaining responsibilities queued for later

For each priority responsibility:
- Success criteria (what does good look like?)
- Collaborators (who do you work with?)
- Data tracked (metrics, systems, documents)
- Recurring tasks (what do you do regularly?)

### Phase 4: People Enrichment
- Manager deep-dive (priorities, preferences, cadence)
- Direct reports (if applicable): context, focus areas, development
- Key stakeholders: relationship, interaction patterns, preferences

People data seeds the memory graph with entities and relationships.

### Phase 5: Cadence
- Recurring meetings (type, frequency, participants, purpose)
- Reporting cycles (what, when, to whom)
- Key dates (board meetings, reviews, deadlines)

### Phase 6: Preferences
Always asked (cannot be extracted):
- Communication style (language, tone, format)
- Working patterns (hours, focus time)
- Self-awareness (blind spots, frustrations, needs help with)
- Hard rules (things to never do)

### Phase 7: Confirmation & Generation
- Review all captured data
- User confirms or corrects
- Generate command centre structure

**Target duration:** 15-20 minutes (faster with good documents)

  ---

  ## Generation Logic

  ### From Onboarding → CLAUDE.md
  ```markdown
  # {Company} {Role} Command Centre

  ## Who You're Helping
  **{Name}** - {Role} at {Company}, reporting to {Manager}.

  ## Communication Style
  {From preferences - language, tone, formality}

  ## Role Overview
  {List of responsibilities}

  ## Skills
  | Skill | Purpose | When to Use |
  {Generated from responsibilities}

  ## Rules
  1. {Standard rules}
  2. {Custom rules from preferences}

  From Responsibility → Skill (with workflows inline)

  # .claude/skills/{slug}/SKILL.md

  ---
  name: {slug}
  description: {Specific triggers and capabilities for auto-discovery. Max 1024 chars.}
  ---

  # {Responsibility Name}

  ## Purpose
  {From "what does success look like"}

  ## Data Locations
  - `{path}` - {From "what data do you track"}

  ## Workflows

  ### {Recurring Task 1}

  **When:** {trigger}

  **Input:**
  - {input}

  **Process:**
  1. {Step}
  2. {Step}

  **Output:**
  {Template}

  **Verification:**
  - [ ] {Observable criterion}

  **Next:** {What happens after}

  ---

  ### {Recurring Task 2}
  ...

  ## Related Files
  - `{path}` - {description}

  ---
  Universal Components

  These are included regardless of role:

  Universal Skills
  ┌──────────────┬─────────────────────────────────────────────┐
  │    Skill     │                   Purpose                   │
  ├──────────────┼─────────────────────────────────────────────┤
  │ session      │ Start (/resume) and end (/preserve) rituals │
  ├──────────────┼─────────────────────────────────────────────┤
  │ humanize     │ Transform AI output to match user's voice   │
  └──────────────┴─────────────────────────────────────────────┘

  Note: Self-improvement is NOT a skill - it's an organic behavioural layer
  in CLAUDE.md that observes and proposes improvements contextually.
  Universal Agents
  ┌──────────────┬──────────────────────────────────────┐
  │    Agent     │               Purpose                │
  ├──────────────┼──────────────────────────────────────┤
  │ weekly-prep  │ Monday planning across all domains   │
  ├──────────────┼──────────────────────────────────────┤
  │ health-check │ Status dashboard before key meetings │
  └──────────────┴──────────────────────────────────────┘
  Universal Hooks
  ┌───────────────┬──────────────────────────┬───────────────────────────┐
  │     Hook      │         Trigger          │          Action           │
  ├───────────────┼──────────────────────────┼───────────────────────────┤
  │ check-actions │ Write to people/, work/  │ Remind about actions.md   │
  ├───────────────┼──────────────────────────┼───────────────────────────┤
  │ check-memory  │ Write to person profiles │ Remind about memory graph │
  └───────────────┴──────────────────────────┴───────────────────────────┘
  ---
  Key Design Principles

  1. Ask, don't assume - All generated content comes from user answers
  2. Start minimal - Generate only what's needed, expand through usage
  3. Observable verification - Every workflow has checkable criteria
  4. Single authority - One file per data type (actions.md = all actions)
  5. Append-only learning - Never delete observations, always grow
  6. Model-aware - Cheap models (Haiku) for bulk, expensive (Sonnet) for reasoning
  7. Hook-driven consistency - Automate reminders, don't block
  8. Weekly retrospective - Built-in improvement cadence
  9. Progressive disclosure - SKILL.md is entry point, reference.md for details

  ---
  Implementation Order

  1. Onboarding questionnaire - The foundation
  2. CLAUDE.md generator - Core configuration
  3. Skill generator - From responsibilities to skills (workflows inline)
  4. Universal components - session, self-improve skills
  5. Hooks system - Consistency automation
  6. Self-improvement loop - Retrospective workflow
  7. Calibration flow - Post-setup refinement