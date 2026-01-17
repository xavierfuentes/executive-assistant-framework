#!/bin/bash
# Hook: check-memory
# Trigger: PostToolUse on Write/Edit to people/*.md files
# Purpose: Remind to update memory graph with new observations about people

set -euo pipefail

INPUT=$(cat)

extract_file_path() {
    local input="$1"

    if command -v jq &> /dev/null; then
        echo "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null
        return
    fi

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

    echo "$input" | grep -oE '"file_path"\s*:\s*"[^"]*"' | head -1 | sed 's/"file_path"\s*:\s*"//' | sed 's/"$//'
}

FILE_PATH=$(extract_file_path "$INPUT")

if [[ -z "$FILE_PATH" ]]; then
    exit 0
fi

if [[ "$FILE_PATH" =~ /people/.*\.md$ ]]; then
    FILENAME=$(basename "$FILE_PATH" .md)
    echo ""
    echo "REMINDER: You've updated a person profile."
    echo "   Consider adding new observations to the memory graph:"
    echo "   mcp__memory__add_observations for entity '$FILENAME'"
    echo ""
fi

exit 0
