#!/bin/bash
  # Hook: {hook-name}
  # Trigger: {PostToolUse|PreToolUse} on {tool} to {path pattern}
  # Purpose: {What this hook does}

  TOOL_INPUT="$1"

  # Extract relevant info from tool input
  FILE_PATH=$(echo "$TOOL_INPUT" | grep -o '"file_path":"[^"]*"' | cut -d'"' -f4)

  # Check if path matches our trigger pattern
  if [[ "$FILE_PATH" =~ {regex-pattern} ]]; then
      echo ""
      echo "⚠️  REMINDER: {What the user should do}"
      echo ""
  fi

  exit 0  # Always exit 0 (informational, not blocking)