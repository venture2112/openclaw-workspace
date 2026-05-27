#!/bin/bash
# Daily Usage Logger - Run via cron to update usage-tracker.md
# Usage: ./daily-usage-logger.sh [message_count]

USAGE_FILE="/root/.openclaw/workspace/usage-tracker.md"
DATE=$(date +%Y-%m-%d)

# Get message count from argument or estimate
if [ -n "$1" ]; then
    MESSAGE_COUNT=$1
else
    # Default estimate for a typical day
    MESSAGE_COUNT=50
fi

# Calculate estimates
TOKENS=$((MESSAGE_COUNT * 4000))
INPUT_TOKENS=$((TOKENS * 70 / 100))
OUTPUT_TOKENS=$((TOKENS * 30 / 100))

# Costs: $0.50/M input, $2.00/M output
TOTAL_COST=$(echo "scale=4; ($INPUT_TOKENS * 0.50 + $OUTPUT_TOKENS * 2.00) / 1000000" | bc)

# Format for display
if [ "$(echo "$TOTAL_COST < 0.01" | bc 2>/dev/null || echo "1")" -eq 1 ]; then
    COST_DISPLAY="~$0.01"
else
    COST_DISPLAY="~\$$TOTAL_COST"
fi

if [ "$TOKENS" -ge 1000 ]; then
    TOKENS_DISPLAY="$(echo "scale=1; $TOKENS / 1000" | bc)K"
else
    TOKENS_DISPLAY="$TOKENS"
fi

# Ensure file exists with header
if [ ! -f "$USAGE_FILE" ]; then
    cat > "$USAGE_FILE" << 'EOF'
# Usage Tracking - Moonshot Costs

## Daily Log

| Date | Messages | Est. Tokens | Est. Cost |
|------|----------|-------------|-----------|
EOF
fi

# Check if date exists
if grep -q "^| $DATE " "$USAGE_FILE"; then
    # Update existing
    EXISTING_LINE=$(grep "^| $DATE " "$USAGE_FILE")
    EXISTING_MSGS=$(echo "$EXISTING_LINE" | awk -F'|' '{print $3}' | tr -d ' ' | sed 's/~//g')
    
    NEW_MSGS=$((EXISTING_MSGS + MESSAGE_COUNT))
    NEW_TOKENS=$((NEW_MSGS * 4000))
    NEW_INPUT=$((NEW_TOKENS * 70 / 100))
    NEW_OUTPUT=$((NEW_TOKENS * 30 / 100))
    NEW_COST=$(echo "scale=4; ($NEW_INPUT * 0.50 + $NEW_OUTPUT * 2.00) / 1000000" | bc)
    
    if [ "$(echo "$NEW_COST < 0.01" | bc 2>/dev/null || echo "1")" -eq 1 ]; then
        NEW_COST_DISPLAY="~$0.01"
    else
        NEW_COST_DISPLAY="~\$$NEW_COST"
    fi
    
    if [ "$NEW_TOKENS" -ge 1000 ]; then
        NEW_TOKENS_DISPLAY="$(echo "scale=1; $NEW_TOKENS / 1000" | bc)K"
    else
        NEW_TOKENS_DISPLAY="$NEW_TOKENS"
    fi
    
    sed -i "s/^| $DATE .*/| $DATE | $NEW_MSGS | ~$NEW_TOKENS_DISPLAY | $NEW_COST_DISPLAY |/" "$USAGE_FILE"
    echo "Updated $DATE: $NEW_MSGS msgs, ~$NEW_TOKENS_DISPLAY tokens, $NEW_COST_DISPLAY"
else
    # Add new row
    sed -i "/^|------/a | $DATE | $MESSAGE_COUNT | ~$TOKENS_DISPLAY | $COST_DISPLAY |" "$USAGE_FILE"
    echo "Logged $DATE: $MESSAGE_COUNT msgs, ~$TOKENS_DISPLAY tokens, $COST_DISPLAY"
fi
