#!/bin/bash
# Daily MEMORY.md compaction script

MEMORY_FILE="/root/.openclaw/workspace/MEMORY.md"
BACKUP_FILE="/root/.openclaw/workspace/memory/backups/MEMORY-$(date +%Y%m%d).md"

# Create backup first
mkdir -p "$(dirname "$BACKUP_FILE")"
cp "$MEMORY_FILE" "$BACKUP_FILE" 2>/dev/null

# Compact: remove empty lines, trailing whitespace, compact multiple spaces
cat "$MEMORY_FILE" | \
  sed 's/[[:space:]]*$//' | \
  cat -s | \
  sed '/^$/N;/^\n$/D' > "${MEMORY_FILE}.tmp" && \
  mv "${MEMORY_FILE}.tmp" "$MEMORY_FILE"

echo "$(date): MEMORY.md compacted, backup at $BACKUP_FILE"
