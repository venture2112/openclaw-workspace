#!/bin/bash
# Process raw data and score opportunities

CONFIG_FILE="$HOME/.streaming-scout/config.json"
DATA_DIR="$HOME/.openclaw/workspace/skills/streaming-opportunity-scout/data"
DATE=${1:-$(date +%Y-%m-%d)}

echo "=== Processing Opportunities for $DATE ==="
echo ""

INPUT_DIR="$DATA_DIR/$DATE"
if [ ! -d "$INPUT_DIR" ]; then
    echo "ERROR: No data found for $DATE"
    echo "Run scout.sh first to collect data"
    exit 1
fi

# Process each raw data file
for file in "$INPUT_DIR"/*.json; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    filename=$(basename "$file")
    echo "Processing: $filename"
    
    # Use OpenClaw to analyze and score each conversation
    # This generates scored opportunities with drafted responses
    
done

echo ""
echo "Processing complete!"
echo "Run ./scripts/review.sh --date $DATE to review scored opportunities"