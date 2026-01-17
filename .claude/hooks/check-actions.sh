#!/bin/bash
# Hook: check-actions
# Trigger: PostToolUse on Write/Edit to people/ or work/ directories
# Purpose: Remind to update actions.md if action items may have emerged

set -euo pipefail

INPUT=$(cat)

# Extract file path using robust JSON parsing
extract_file_path() {
    local input="$1"

    # Try jq first (handles all edge cases)
    if command -v jq &> /dev/null; then
        echo "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null
        return
    fi

    # Fallback to Python
    if command -v python3 &> /dev/null; then
        echo "$input" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('tool_input', {}).get('file_path', '') or '')
except Exception:
    print('')
" 2>/dev/null
        return
    fi

    # Last resort: simple grep (may fail on edge cases)
    echo "$input" | grep -oE '"file_path"\s*:\s*"[^"]*"' | head -1 | sed 's/"file_path"\s*:\s*"//' | sed 's/"$//'
}

FILE_PATH=$(extract_file_path "$INPUT")

# Exit silently if we couldn't extract a path
if [[ -z "$FILE_PATH" ]]; then
    exit 0
fi

# Check if path is in people/ or work/ directories (but not actions.md itself)
if [[ "$FILE_PATH" =~ /(people|work)/ ]] && [[ ! "$FILE_PATH" =~ actions\.md$ ]]; then
    echo ""
    echo "REMINDER: You've updated a file in people/ or work/."
    echo "   If any action items emerged, consider updating work/actions.md"
    echo ""
fi

exit 0
