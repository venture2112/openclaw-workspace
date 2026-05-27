#!/bin/bash
# Scout script - Run Apify actors to find streaming-related conversations

set -e

CONFIG_FILE="$HOME/.streaming-scout/config.json"
DATA_DIR="$HOME/.streaming-scout/data"

# Default values
PLATFORM="reddit"
KEYWORDS=""
LIMIT=50
DATE=$(date +%Y-%m-%d)

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --platform)
            PLATFORM="$2"
            shift 2
            ;;
        --keywords)
            KEYWORDS="$2"
            shift 2
            ;;
        --limit)
            LIMIT="$2"
            shift 2
            ;;
        --date)
            DATE="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Validate
if [ -z "$KEYWORDS" ]; then
    echo "ERROR: --keywords is required"
    echo "Usage: ./scout.sh --platform reddit --keywords 'cable alternatives'"
    exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
    echo "ERROR: Config not found. Run ./scripts/setup.sh first"
    exit 1
fi

APIFY_KEY=$(jq -r '.apify_api_key' "$CONFIG_FILE")
if [ -z "$APIFY_KEY" ] || [ "$APIFY_KEY" = "null" ]; then
    echo "ERROR: Apify API key not configured"
    exit 1
fi

# Create data directory for today
TODAY_DIR="$DATA_DIR/$DATE"
mkdir -p "$TODAY_DIR"

echo "=== Streaming Opportunity Scout ==="
echo "Platform: $PLATFORM"
echo "Keywords: $KEYWORDS"
echo "Date: $DATE"
echo ""

# Define Apify actors by platform
case $PLATFORM in
    reddit)
        ACTOR="trudax/reddit-scraper"
        ACTOR_INPUT=$(cat <<EOF
{
    "searches": ["$KEYWORDS"],
    "maxResults": $LIMIT,
    "sort": "new",
    "time": "day"
}
EOF
)
        ;;
    quora)
        ACTOR="quora-scraper"  # Replace with actual actor ID
        ACTOR_INPUT="{\"queries\": [\"$KEYWORDS\"], \"maxResults\": $LIMIT}"
        ;;
    youtube)
        ACTOR="youtube-comments-scraper"  # Replace with actual actor ID
        ACTOR_INPUT="{\"searchKeywords\": [\"$KEYWORDS\"], \"maxResults\": $LIMIT}"
        ;;
    all)
        echo "Running all platforms..."
        ./scripts/scout.sh --platform reddit --keywords "$KEYWORDS" --limit "$LIMIT" --date "$DATE"
        ./scripts/scout.sh --platform quora --keywords "$KEYWORDS" --limit "$LIMIT" --date "$DATE"
        ./scripts/scout.sh --platform youtube --keywords "$KEYWORDS" --limit "$LIMIT" --date "$DATE"
        exit 0
        ;;
    *)
        echo "ERROR: Unknown platform: $PLATFORM"
        echo "Supported: reddit, quora, youtube, all"
        exit 1
        ;;
esac

echo "Running Apify actor: $ACTOR"
echo ""

# Run Apify actor via API
RESPONSE=$(curl -s -X POST "https://api.apify.com/v2/acts/$ACTOR/runs?token=$APIFY_KEY" \
    -H "Content-Type: application/json" \
    -d "$ACTOR_INPUT")

RUN_ID=$(echo "$RESPONSE" | jq -r '.data.id')
if [ -z "$RUN_ID" ] || [ "$RUN_ID" = "null" ]; then
    echo "ERROR: Failed to start Apify run"
    echo "Response: $RESPONSE"
    exit 1
fi

echo "Run ID: $RUN_ID"
echo "Waiting for completion..."

# Poll for completion
while true; do
    STATUS=$(curl -s "https://api.apify.com/v2/actor-runs/$RUN_ID?token=$APIFY_KEY" | jq -r '.data.status')
    echo -n "."
    
    if [ "$STATUS" = "SUCCEEDED" ]; then
        echo ""
        echo "Run completed successfully!"
        break
    elif [ "$STATUS" = "FAILED" ] || [ "$STATUS" = "ABORTED" ]; then
        echo ""
        echo "ERROR: Run $STATUS"
        exit 1
    fi
    
    sleep 5
done

# Get dataset ID and download results
DATASET_ID=$(curl -s "https://api.apify.com/v2/actor-runs/$RUN_ID?token=$APIFY_KEY" | jq -r '.data.defaultDatasetId')
OUTPUT_FILE="$TODAY_DIR/${PLATFORM}_${KEYWORDS// /_}.json"

curl -s "https://api.apify.com/v2/datasets/$DATASET_ID/items?token=$APIFY_KEY&format=json" > "$OUTPUT_FILE"

echo ""
echo "Results saved to: $OUTPUT_FILE"
echo ""

# Count results
COUNT=$(jq 'length' "$OUTPUT_FILE")
echo "Found $COUNT conversations"
echo ""
echo "Next: Run ./scripts/process.sh to analyze and score opportunities"