---
  name: {agent-name}
  description: {When to use this agent}
  hooks:
    Stop:
      - type: prompt
        prompt: |
          Before stopping, verify:
          1. {Condition 1}
          2. {Condition 2}
          Respond with JSON: {"decision": "stop"} or {"decision": "continue", "reason": "..."}
  ---

  # {Agent Name}

  ## Purpose
  {What this agent aggregates/orchestrates}

  ## Execution
  This agent runs the following in parallel:

  1. **{Task 1}** → Invokes `{skill}` skill, `{workflow}` workflow
  2. **{Task 2}** → Invokes `{skill}` skill, `{workflow}` workflow

  ## Output
  {Consolidated format description}

  ## When to Run
  {Trigger scenarios}