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
  │   │       ├── SKILL.md          # Skill metadata + overview
  │   │       ├── workflows/        # Step-by-step procedures
  │   │       └── templates/        # Data structure templates
  │   ├── agents/                   # Cross-domain orchestrators
  │   ├── hooks/                    # Consistency automation scripts
  │   ├── memory.jsonl              # Knowledge graph (MCP)
  │   ├── settings.json             # Hook configuration
  │   └── bootstrap/                # Onboarding system
  │       ├── onboarding.md         # Questionnaire workflow
  │       ├── generators/           # Code that creates skills/workflows
  │       └── calibration.md        # Post-setup refinement
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
  │       ├── improvements.md       # Prioritised queue
  │       ├── patterns.md           # Anti-patterns + learnings
  │       └── session-log.jsonl     # Append-only history
  │
  └── me/                           # User's personal files

  ---

  ## Core Concepts

  ### Skills
  Domain expertise containers. Each skill has:
  - **SKILL.md** - Metadata, purpose, data locations
  - **workflows/** - Step-by-step procedures for tasks
  - **templates/** - Data structure templates

  Skills are auto-discovered by Claude based on their description.

  ### Workflows
  Every workflow follows this structure:
  - **Purpose** - One sentence, what problem it solves
  - **Input** - What data/parameters needed
  - **Process** - Numbered steps
  - **Output Format** - Template with placeholders
  - **Verification** - Observable checklist (not "looks good" but "X scored Y/N")
  - **Next Steps** - What happens after

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

  ### Memory (Knowledge Graph)
  MCP server storing entities and relationships:
  - People (team, stakeholders, manager)
  - Relationships (reports-to, works-with)
  - Observations (facts learned over time)

  Append-only - never delete, always grow.

  ### Self-Improvement Loop
  The system learns from usage:
  1. **Triggers** - Repeated manual work (3×), missing data, workflow gaps, corrections
  2. **Capture** - Log to improvements.md with priority
  3. **Review** - Weekly retrospective reviews queue
  4. **Implement** - Make approved changes to skills/workflows

  ---

  ## Onboarding Flow

  ### Phase 1: Identity & Role
  - Name, title, company, location
  - Who do you report to?
  - Communication style preferences (language, tone, formality)

  ### Phase 2: Responsibilities Discovery
  - List core responsibilities (these become skills)
  - For each: success criteria, collaborators, data tracked, recurring tasks

  ### Phase 3: People & Relationships
  - Direct reports (name, role, tenure, focus areas)
  - Key stakeholders (name, relationship, communication preference)
  - Manager (name, priorities, update preferences)

  ### Phase 4: Operational Cadence
  - Regular meetings (1:1s, team meetings, cross-functional)
  - Reporting cycles (weekly, monthly, quarterly)
  - Key dates (board meetings, reviews, deadlines)

  ### Phase 5: Personal Context
  - Working preferences, productivity patterns
  - Known blind spots
  - What frustrates you? Where do you need most help?

  ---

  ## Generation Logic

  ### From Onboarding → CLAUDE.md
  {Company} {Role} Command Centre

  Who You're Helping

  {Name} - {Role} at {Company}, reporting to {Manager}.

  Communication Style

  {From preferences - language, tone, formality}

  Role Overview

  {List of responsibilities}

  Skills

  | Skill | Purpose | When to Use |
  {Generated from responsibilities}

  Rules

  1. {Standard rules}
  2. {Custom rules from preferences}

  ### From Responsibility → Skill
  .claude/skills/{slug}/SKILL.md

  ---name: {slug}
  description: {One-line trigger for auto-discovery}

  {Responsibility Name}

  Purpose

  {From "what does success look like"}

  Data Locations

  {From "what data do you track"}

  Key Workflows

  {Derived from "recurring tasks"}

  ### From Recurring Task → Workflow
  .claude/skills/{skill}/workflows/{task-slug}.md

  {Task Name}

  Purpose

  {From task description}

  Input

  {What's needed}

  Process

  1. {Step}
  2. {Step}

  Output Format

  {Template}

  Verification

  - {Observable criterion}

  Next Steps

  {What happens after}

  ---

  ## Universal Components

  These are included regardless of role:

  ### Universal Skills
  | Skill | Purpose |
  |-------|---------|
  | `session` | Start (/resume) and end (/preserve) rituals |
  | `self-improve` | System evolution, retrospectives |
  | `humanize` | Transform AI output to match user's voice |

  ### Universal Agents
  | Agent | Purpose |
  |-------|---------|
  | `weekly-prep` | Monday planning across all domains |
  | `health-check` | Status dashboard before key meetings |

  ### Universal Hooks
  | Hook | Trigger | Action |
  |------|---------|--------|
  | `check-actions` | Write to people/, work/ | Remind about actions.md |
  | `check-memory` | Write to person profiles | Remind about memory graph |

  ---

  ## Key Design Principles

  1. **Ask, don't assume** - All generated content comes from user answers
  2. **Start minimal** - Generate only what's needed, expand through usage
  3. **Observable verification** - Every workflow has checkable criteria
  4. **Single authority** - One file per data type (actions.md = all actions)
  5. **Append-only learning** - Never delete observations, always grow
  6. **Model-aware** - Cheap models (Haiku) for bulk, expensive (Sonnet) for reasoning
  7. **Hook-driven consistency** - Automate reminders, don't block
  8. **Weekly retrospective** - Built-in improvement cadence

  ---

  ## Implementation Order

  1. **Onboarding questionnaire** - The foundation
  2. **CLAUDE.md generator** - Core configuration
  3. **Skill generator** - From responsibilities to skills
  4. **Workflow generator** - From tasks to workflows
  5. **Universal components** - session, self-improve skills
  6. **Hooks system** - Consistency automation
  7. **Self-improvement loop** - Retrospective workflow
  8. **Calibration flow** - Post-setup refinement