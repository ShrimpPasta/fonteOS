#!/bin/bash
# Wikilink validation hook for FonteOS vaults
# Runs after Edit/Write on .md files — warns if no wikilinks (isolated node)

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Fallback to env var if stdin parsing fails
[ -z "$FILE_PATH" ] && FILE_PATH="$CLAUDE_TOOL_INPUT_FILE_PATH"
[ -z "$FILE_PATH" ] && exit 0

# Only check markdown files
[[ "$FILE_PATH" != *.md ]] && exit 0

# Get repo-relative path
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
[ -z "$REPO_ROOT" ] && exit 0
RELPATH="${FILE_PATH#$REPO_ROOT/}"

# Skip files that legitimately don't need wikilinks
BASENAME=$(basename "$FILE_PATH")

# Config/meta files
[[ "$BASENAME" == "CLAUDE.md" ]] && exit 0
[[ "$BASENAME" == "README.md" ]] && exit 0
[[ "$BASENAME" == "SECURITY.md" ]] && exit 0
[[ "$BASENAME" == "session-state.md" ]] && exit 0
[[ "$BASENAME" == "stream-mapping.yaml" ]] && exit 0

# Logs (generated content)
[[ "$RELPATH" == logs/* ]] && exit 0

# Specs (technical docs)
[[ "$RELPATH" == */specs/* ]] && exit 0

# Docs (documentation, not knowledge graph nodes)
[[ "$RELPATH" == docs/* ]] && exit 0

# Landing page
[[ "$RELPATH" == landing/* ]] && exit 0

# Check for wikilinks
if [ -f "$FILE_PATH" ] && ! grep -q '\[\[' "$FILE_PATH" 2>/dev/null; then
  echo "WARNING: '$BASENAME' has no [[wikilinks]] — isolated node in Obsidian graph. Add at least one link to a related note."
fi

exit 0
