# Executive Assistant Framework

A self-bootstrapping AI command centre that any executive can configure through conversation.

## What This Is

This framework creates personalised AI assistants for executives. Instead of generic prompts, it:

1. **Onboards through conversation** - Asks structured questions (or extracts from your CV/JD)
2. **Generates custom structure** - Creates CLAUDE.md, skills, workflows based on your role
3. **Learns over time** - Observes patterns and proposes improvements organically

The result: an AI assistant that knows your responsibilities, your team, your preferences, and gets better the more you use it.

## Quick Start

### 1. Run Onboarding

```
/onboarding
```

Or paste your CV/job description and let the system extract what it needs.

### 2. Generate Your Command Centre

After completing onboarding:

```
/generate ./my-command-centre
```

### 3. Start Using It

Navigate to your generated directory and:

```
/resume
```

## What Gets Generated

```
your-project/
├── CLAUDE.md                    # Your personalised instructions
├── people/
│   ├── manager.md               # Your manager's context
│   ├── team/                    # Direct report profiles
│   └── stakeholders/            # Key relationship profiles
├── work/
│   └── actions.md               # Eisenhower matrix for tasks
├── reference/
│   └── system/
│       ├── improvements.md      # Implemented improvements log
│       └── patterns.md          # Learned patterns
└── .claude/
    ├── skills/                  # Your responsibility-based skills
    ├── agents/                  # weekly-prep, health-check
    └── hooks/                   # Consistency reminders
```

## Key Features

### Document-First Onboarding

Don't answer 40 questions. Paste your CV, job description, or LinkedIn profiles and the system extracts what it needs. Only asks questions for gaps.

### Skills From Responsibilities

Your responsibilities become skills with workflows:

- "Engineering Hiring" → `hiring` skill with pipeline review, retro workflows
- "Technical Strategy" → `strategy` skill with architecture review workflows

### Memory Graph

People you work with become entities in a knowledge graph:
- Tracks relationships (reports-to, works-with)
- Accumulates observations over time
- Enables context-aware assistance

### Organic Self-Improvement

Not a skill you invoke - a behaviour woven in. The assistant:
- Notices repeated manual work
- Proposes workflows after 3+ occurrences
- Learns from corrections
- Never interrupts urgent work

## Project Structure

```
executive-assistant-framework/
├── ARCHITECTURE.md              # Full system design
├── CLAUDE.md                    # Framework instructions
├── examples/                    # Templates
│   ├── skill-template.md
│   ├── agent-template.md
│   └── hook-template.sh
└── .claude/
    ├── bootstrap/
    │   ├── onboarding.md        # Onboarding workflow
    │   ├── answers-template.md  # Answer schema
    │   ├── mapping.md           # Field → output mapping
    │   ├── extraction-prompts.md# CV/JD parsing prompts
    │   ├── calibration.md       # Post-setup refinement
    │   ├── sample-answers.md    # Example completed onboarding
    │   ├── sample-output.md     # What generation produces
    │   └── generators/          # Generation templates
    ├── skills/
    │   ├── generate/            # Orchestrates generation
    │   ├── session/             # /resume, /preserve
    │   └── humanize/            # Voice matching
    ├── agents/
    │   ├── weekly-prep.md       # Monday planning
    │   └── health-check.md      # Pre-meeting status
    └── hooks/
        ├── check-actions.sh     # Remind about actions.md
        └── check-memory.sh      # Remind about memory graph
```

## Commands

| Command | Purpose |
|---------|---------|
| `/onboarding` | Start the onboarding flow |
| `/generate [path]` | Generate command centre from answers |
| `/resume` | Start a session with context |
| `/preserve` | Save context before ending |
| `/humanize` | Rewrite text in your voice |

## Customisation

### After Generation

The generated command centre is yours to modify:

- Edit `CLAUDE.md` to adjust rules
- Add/remove skills in `.claude/skills/`
- Update people profiles as relationships evolve
- The system adapts to your changes

### Calibration

First week not quite right? Use natural language:

- "Add Sarah to my team"
- "Update the hiring skill"
- "Change my communication preferences"

See `.claude/bootstrap/calibration.md` for full calibration guide.

## Design Principles

1. **Ask, don't assume** - All generated content comes from your answers
2. **Start minimal** - Generate only what's needed, expand through usage
3. **Observable verification** - Every workflow has checkable criteria
4. **Single authority** - One file per data type (actions.md = all actions)
5. **Hooks remind, never block** - Suggestions only, you decide

## Testing

To test the framework:

1. Run onboarding and complete all phases (~15-20 min)
2. Generate to a sandbox: `/generate ./sandbox`
3. Check the generated files make sense
4. Try `/resume` in the generated directory

**Feedback wanted:**
- Does onboarding flow naturally?
- Are extracted details correct?
- Do generated skills match your responsibilities?

## Requirements

- Claude Code CLI
- MCP memory server (for knowledge graph)

## Contributing

This is both a working framework and documentation for building similar systems. See `ARCHITECTURE.md` for the full design.

## License

MIT
