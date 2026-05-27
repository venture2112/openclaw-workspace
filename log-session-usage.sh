#!/bin/bash
# Session Usage Logger - Appends to usage-tracker.md
# Run at end of session to log message count and estimated cost

USAGE_FILE="/root/.openclaw/workspace/usage-tracker.md"
DATE=$(date +%Y-%m-%d)

# Get session message count from OpenClaw status
SESSION_INFO=$(openclaw status --json 2>/dev/null || echo '{}')
MESSAGE_COUNT=$(echo "$SESSION_INFO" | grep -o '"messages":[0-9]*' | cut -d: -f2 || echo "0")

# If we can't get actual count, estimate from session duration
if [ "$MESSAGE_COUNT" -eq 0 ]; then
    # Rough estimate: ~10 messages per active session hour
    MESSAGE_COUNT=10
fi

# Calculate estimates (Kimi K2.5 rates)
# Avg 4000 tokens per message, 70/30 input/output split
TOKENS=$((MESSAGE_COUNT * 4000))
INPUT_TOKENS=$((TOKENS * 70 / 100))
OUTPUT_TOKENS=$((TOKENS * 30 / 100))

# Costs: $0.50/M input, $2.00/M output
INPUT_COST=$(echo "scale=4; $INPUT_TOKENS * 0.50 / 1000000" | bc)
OUTPUT_COST=$(echo "scale=4; $OUTPUT_TOKENS * 2.00 / 1000000" | bc)
TOTAL_COST=$(echo "scale=4; $INPUT_COST + $OUTPUT_COST" | bc)

# Format cost
if [ "$(echo "$TOTAL_COST < 0.01" | bc)" -eq 1 ]; then
    COST_DISPLAY="~$0.01"
else
    COST_DISPLAY="~\$$TOTAL_COST"
fi

# Format tokens
if [ "$TOKENS" -ge 1000 ]; then
    TOKENS_DISPLAY="$(echo "scale=1; $TOKENS / 1000" | bc)K"
else
    TOKENS_DISPLAY="$TOKENS"
fi

# Check if date already exists in log
if grep -q "^| $DATE " "$USAGE_FILE" 2>/dev/null; then
    # Update existing row - add to existing numbers
    EXISTING_LINE=$(grep "^| $DATE " "$USAGE_FILE")
    EXISTING_MSGS=$(echo "$EXISTING_LINE" | awk -F'|' '{print $3}' | tr -d ' ' | sed 's/~//g')
    EXISTING_TOKENS=$(echo "$EXISTING_LINE" | awk -F'|' '{print $4}' | tr -d ' ~K' | sed 's/K/*1000/g' | bc 2>/dev/null || echo "0")
    
    NEW_MSGS=$((EXISTING_MSGS + MESSAGE_COUNT))
    NEW_TOKENS=$((EXISTING_TOKENS + TOKENS))
    
    # Recalculate cost
    NEW_INPUT=$((NEW_TOKENS * 70 / 100))
    NEW_OUTPUT=$((NEW_TOKENS * 30 / 100))
    NEW_COST=$(echo "scale=4; ($NEW_INPUT * 0.50 + $NEW_OUTPUT * 2.00) / 1000000" | bc)
    
    if [ "$(echo "$NEW_COST < 0.01" | bc)" -eq 1 ]; then
        NEW_COST_DISPLAY="~$0.01"
    else
        NEW_COST_DISPLAY="~\$$NEW_COST"
    fi
    
    if [ "$NEW_TOKENS" -ge 1000 ]; then
        NEW_TOKENS_DISPLAY="$(echo "scale=1; $NEW_TOKENS / 1000" | bc)K"
    else
        NEW_TOKENS_DISPLAY="$NEW_TOKENS"
    fi
    
    # Replace the line
    sed -i "s/^| $DATE .*/| $DATE | $NEW_MSGS | ~$NEW_TOKENS_DISPLAY | $NEW_COST_DISPLAY |/" "$USAGE_FILE"
    echo "Updated $DATE: $NEW_MSGS msgs, ~$NEW_TOKENS_DISPLAY tokens, $NEW_COST_DISPLAY"
else
    # Add new row
    sed -i "/^|------/a | $DATE | $MESSAGE_COUNT | ~$TOKENS_DISPLAY | $COST_DISPLAY |" "$USAGE_FILE"
    echo "Logged $DATE: $MESSAGE_COUNT msgs, ~$TOKENS_DISPLAY tokens, $COST_DISPLAY"
fi
