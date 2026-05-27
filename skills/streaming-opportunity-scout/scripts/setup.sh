#!/bin/bash
# Setup script for Streaming Opportunity Scout
# Prompts for all required API keys and credentials

set -e

CONFIG_DIR="$HOME/.streaming-scout"
CONFIG_FILE="$CONFIG_DIR/config.json"

echo "=== Streaming Opportunity Scout Setup ==="
echo ""
echo "This script will prompt you for API credentials."
echo "All credentials are stored locally in $CONFIG_FILE"
echo ""

# Create config directory
mkdir -p "$CONFIG_DIR"

# Initialize JSON
config='{}'

echo "--- REQUIRED ---"
echo ""

# Apify API Key (Required)
echo "Apify is the PRIMARY data source for this skill."
echo "Get your API key at: https://console.apify.com/account/integrations"
read -rp "Apify API Key: " apify_key
if [ -z "$apify_key" ]; then
    echo "ERROR: Apify API Key is required"
    exit 1
fi
config=$(echo "$config" | jq --arg key "$apify_key" '. + {apify_api_key: $key}')

echo ""
echo "--- OPTIONAL (enhances monitoring) ---"
echo ""

# Reddit API
read -rp "Enable Reddit monitoring? (y/n): " enable_reddit
if [[ "$enable_reddit" =~ ^[Yy]$ ]]; then
    echo "Get Reddit API credentials at: https://www.reddit.com/prefs/apps"
    read -rp "Reddit Client ID: " reddit_client_id
    read -rp "Reddit Client Secret: " reddit_client_secret
    read -rp "Reddit User Agent (e.g., 'StreamingScoutBot/1.0 by YourUsername'): " reddit_user_agent
    
    config=$(echo "$config" | jq \
        --arg id "$reddit_client_id" \
        --arg secret "$reddit_client_secret" \
        --arg ua "$reddit_user_agent" \
        '. + {reddit: {enabled: true, client_id: $id, client_secret: $secret, user_agent: $ua}}')
else
    config=$(echo "$config" | jq '. + {reddit: {enabled: false}}')
fi

# Discord Bot
read -rp "Enable Discord monitoring? (y/n): " enable_discord
if [[ "$enable_discord" =~ ^[Yy]$ ]]; then
    echo "Create a Discord bot at: https://discord.com/developers/applications"
    read -rp "Discord Bot Token: " discord_token
    config=$(echo "$config" | jq --arg token "$discord_token" '. + {discord: {enabled: true, bot_token: $token}}')
else
    config=$(echo "$config" | jq '. + {discord: {enabled: false}}')
fi

# YouTube Data API
read -rp "Enable YouTube comment monitoring? (y/n): " enable_youtube
if [[ "$enable_youtube" =~ ^[Yy]$ ]]; then
    echo "Get YouTube Data API key at: https://console.cloud.google.com/apis/credentials"
    read -rp "YouTube Data API Key: " youtube_key
    config=$(echo "$config" | jq --arg key "$youtube_key" '. + {youtube: {enabled: true, api_key: $key}}')
else
    config=$(echo "$config" | jq '. + {youtube: {enabled: false}}')
fi

# X/Twitter API
read -rp "Enable X/Twitter monitoring? (y/n): " enable_x
if [[ "$enable_x" =~ ^[Yy]$ ]]; then
    echo "Get X API credentials at: https://developer.twitter.com/en/portal/dashboard"
    read -rp "X Bearer Token: " x_bearer
    config=$(echo "$config" | jq --arg token "$x_bearer" '. + {x_twitter: {enabled: true, bearer_token: $token}}')
else
    config=$(echo "$config" | jq '. + {x_twitter: {enabled: false}}')
fi

# Save config
echo "$config" | jq . > "$CONFIG_FILE"
chmod 600 "$CONFIG_FILE"

echo ""
echo "=== Setup Complete ==="
echo "Configuration saved to: $CONFIG_FILE"
echo ""
echo "Next steps:"
echo "  1. Run: ./scripts/scout.sh --platform reddit --keywords 'cable alternatives'"
echo "  2. Review results: ./scripts/review.sh --date today"
echo "  3. Generate daily report: ./scripts/daily-report.sh"