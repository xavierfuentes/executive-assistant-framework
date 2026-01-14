#!/bin/bash
# Hook: check-memory
# Trigger: PostToolUse on Write/Edit to people/*.md files
# Purpose: Remind to update memory graph with new observations about people

TOOL_INPUT="$1"

# Extract file path from tool input
FILE_PATH=$(echo "$TOOL_INPUT" | grep -oE '"file_path"\s*:\s*"[^"]*"' | sed 's/"file_path"\s*:\s*"//' | sed 's/"$//')

# Check if path is a person profile file
if [[ "$FILE_PATH" =~ ^.*/people/.*\.md$ ]]; then
    # Extract person name from filename for helpful message
    FILENAME=$(basename "$FILE_PATH" .md)

    echo ""
    echo "🧠 REMINDER: You've updated a person profile."
    echo "   Consider adding new observations to the memory graph:"
    echo "   mcp__memory__add_observations for entity '$FILENAME'"
    echo ""
fi

exit 0  # Always exit 0 (reminder only, never blocks)
