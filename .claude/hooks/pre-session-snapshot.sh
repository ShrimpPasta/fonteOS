#!/bin/bash
# Pre-session snapshot: tags current commit before Claude starts working.
# Revert to snapshot: git checkout snapshot-YYYY-MM-DD-HHMM
# List snapshots:     git tag -l "snapshot-*"
# Delete old:         git tag -d snapshot-YYYY-MM-DD-HHMM

cd "$(git rev-parse --show-toplevel 2>/dev/null)" || exit 1

TAG="snapshot-$(date +%Y-%m-%d-%H%M)"

if git diff --quiet && git diff --cached --quiet; then
  git tag "$TAG" 2>/dev/null
  echo "Snapshot: $TAG"
else
  echo "Snapshot skipped — uncommitted changes. Commit first."
fi
