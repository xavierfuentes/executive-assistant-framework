#!/bin/bash
# Hook: check-actions
# Trigger: PostToolUse on Write/Edit to people/ or work/ directories
# Purpose: Remind to update actions.md if action items may have emerged

# Read JSON input from stdin
INPUT=$(cat)

# Extract file path from tool input
FILE_PATH=$(echo "$INPUT" | grep -oE '"file_path"\s*:\s*"[^"]*"' | sed 's/"file_path"\s*:\s*"//' | sed 's/"$//')

# Check if path is in people/ or work/ directories (but not actions.md itself)
if [[ "$FILE_PATH" =~ ^.*/(people|work)/ ]] && [[ ! "$FILE_PATH" =~ actions\.md$ ]]; then
    echo ""
    echo "📋 REMINDER: You've updated a file in people/ or work/."
    echo "   If any action items emerged, consider updating work/actions.md"
    echo ""
fi

exit 0  # Always exit 0 (reminder only, never blocks)
