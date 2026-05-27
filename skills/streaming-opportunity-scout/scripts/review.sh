#!/bin/bash
# Interactive review mode for scored opportunities

CONFIG_FILE="$HOME/.streaming-scout/config.json"
DATA_DIR="$HOME/.streaming-scout/data"

DATE=$(date +%Y-%m-%d)
MIN_SCORE=1

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --date)
            DATE="$2"
            shift 2
            ;;
        --min-score)
            MIN_SCORE="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

INPUT_DIR="$DATA_DIR/$DATE/processed"

if [ ! -d "$INPUT_DIR" ]; then
    echo "ERROR: No processed data found for $DATE"
    echo "Run ./scripts/process.sh first"
    exit 1
fi

echo "=== Opportunity Review - $DATE ==="
echo "Minimum score: $MIN_SCORE"
echo ""

# List opportunities meeting criteria
# In actual implementation, this would iterate through scored opportunities
# and present them interactively

echo "[Review mode - interactive selection would go here]"
echo ""
echo "For each opportunity, you can:"
echo "  [a] Approve - Mark for follow-up"
echo "  [r] Reject - Skip this opportunity"
echo "  [e] Edit - Modify the drafted response"
echo "  [s] Skip - Come back to this later"
echo ""
echo "Approved opportunities are saved for posting when you're ready."