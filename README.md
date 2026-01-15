# Executive Assistant Framework

A self-bootstrapping AI command centre for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that any executive can configure through conversation.

## What This Is

This framework creates personalised AI assistants for executives. Instead of generic prompts, it:

1. **Onboards through conversation** - Asks structured questions (or extracts from your CV/JD)
2. **Generates custom structure** - Creates CLAUDE.md, skills, workflows based on your role
3. **Learns over time** - Observes patterns and proposes improvements organically

The result: an AI assistant that knows your responsibilities, your team, your preferences, and gets better the more you use it.

## Quick Start

### Prerequisites

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed
- MCP servers configured (see [MCP Server Setup](#mcp-server-setup) below)

### 1. Start Claude in this directory

```bash
cd executive-assistant-framework
claude
```

### 2. Run onboarding

Once Claude is running, type:

```
/onboarding
```

This starts a ~15-20 minute conversation where Claude learns about your role, team, and preferences. You can paste your CV or job description to speed this up.

### 3. Generate your command centre

After completing onboarding, type:

```
/generate ./my-command-centre
```

**Why a separate directory?** This framework is a reusable template. The `/generate` command transforms your onboarding answers into a personalised command centre with your own `CLAUDE.md`, skills, and people files. You keep the framework intact and get your own working directory.

### 4. Start using your command centre

```bash
cd my-command-centre
claude
```

Then type `/resume` to begin your first session. From now on, this is where you work - Claude reads your personalised `CLAUDE.md` and knows your context.

**Tip:** Open your command centre folder in [Obsidian](https://obsidian.md) for a visual markdown editor with graph view.

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

## MCP Server Setup

The framework uses two MCP (Model Context Protocol) servers for enhanced functionality:

### Memory Server

Provides a persistent knowledge graph for tracking people, relationships, and observations over time.

**Install:**

```bash
claude mcp add memory -- npx -y @modelcontextprotocol/server-memory
```

**What it enables:**

- People you work with stored as entities
- Relationships tracked (reports-to, works-with)
- Observations accumulated over time
- Self-improvement pattern detection

### Context7 Server

Provides up-to-date documentation lookup for any programming library.

**Install:**

```bash
claude mcp add context7 -- npx -y @upstash/context7-mcp
```

**What it enables:**

- Current documentation for any library
- Code examples from official sources
- Answers technical questions with accurate, recent information

### Verifying Setup

After installation, restart Claude Code and check MCP servers are connected:

```bash
claude mcp list
```

You should see both `memory` and `context7` listed.

**Note:** The generated command centre includes an `.mcp.json` file with these servers pre-configured.

## Testing

To test the framework:

1. Start Claude in the framework directory: `cd executive-assistant-framework && claude`
2. Run `/onboarding` and complete all phases (~15-20 min)
3. Generate to a sandbox: `/generate ./sandbox`
4. Check the generated files make sense
5. Start Claude in the sandbox: `cd sandbox && claude`
6. Try `/resume` to begin a session

**Feedback wanted:**

- Does onboarding flow naturally?
- Are extracted details correct?
- Do generated skills match your responsibilities?

## Contributing

This is both a working framework and documentation for building similar systems. See `ARCHITECTURE.md` for the full design.

## License

MIT
