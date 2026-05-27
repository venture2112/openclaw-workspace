---
name: streaming-opportunity-scout
description: Monitor public online conversations about cable alternatives, sports streaming, cord cutting, and rising streaming costs using Apify. Use when the user wants to find leads and engagement opportunities on Reddit, Quora, YouTube comments, forums, and public Discord communities related to streaming frustrations, sports access, and entertainment savings. Activates on commands like /streaming scout, /scout streaming, /find streaming leads, /monitor cord cutting, or requests to track streaming/sports pricing complaints.
---

# Streaming Opportunity Scout

Find and engage with people discussing cable alternatives, sports streaming, and rising streaming costs across public online platforms.

## Command Trigger

Type `/streaming scout` to activate this skill instantly.

## Quick Start

1. **Setup credentials** (first run only):
   ```bash
   ./scripts/setup.sh
   ```
   This prompts for all required API keys and stores them in `~/.streaming-scout/config.json`.

2. **Run a scan**:
   ```bash
   ./scripts/scout.sh --platform reddit --keywords "cable alternatives"
   ```

3. **Generate daily summary**:
   ```bash
   ./scripts/daily-report.sh
   ```

## Required Credentials

The setup script will prompt for:

| Service | Purpose | Required? |
|---------|---------|-----------|
| Apify API Key | Primary scraping/monitoring | **Yes** |
| Reddit API (client ID, secret, user agent) | Reddit monitoring | Optional |
| Discord Bot Token | Public Discord communities | Optional |
| YouTube Data API Key | YouTube comments | Optional |
| X/Twitter API (Bearer token) | X conversations | Optional |

## Usage Patterns

### One-off Scans

Search specific keywords across platforms:
```bash
./scripts/scout.sh --platform reddit --keywords "YouTube TV price increase"
./scripts/scout.sh --platform all --keywords "NFL streaming cheap"
```

**IMPORTANT:** Always filter for recent content only (last 14-21 days maximum). Older posts are not viable engagement opportunities.

### Continuous Monitoring

Set up daily automated scans via cron (see references/cron-setup.md).

### Review and Respond

After scanning, review opportunities:
```bash
./scripts/review.sh --date today --min-score 7
```

This opens interactive review mode to:
- View summarized conversations
- See intent scores (1-10)
- Read drafted responses
- Approve/reject each opportunity

## Intent Scoring (1-10)

| Score | Description | Example |
|-------|-------------|---------|
| 9-10 | Ready to buy/switch | "What's the cheapest way to watch NFL without cable?" |
| 7-8 | Strong frustration | "These streaming prices are ridiculous, might cancel" |
| 5-6 | Research phase | "Comparing YouTube TV vs Hulu Live" |
| 3-4 | Casual mention | "Yeah sports streaming is expensive" |
| 1-2 | Off-topic or venting | General complaints about TV quality |

## Response Guidelines

**Tone:** Helpful, casual, authentic, non-corporate

**Do:**
- Be conversational
- Share personal experience ("we found...")
- Offer help without pushing
- Match the platform's vibe

**Don't:**
- Use corporate speak
- Make unverifiable claims
- Spam or copy-paste
- Auto-post without approval

**Example good response:**
> "I totally get it. The sports subscriptions are getting out of hand. We found a lower-cost setup that's been working well for us so far. Happy to share if you're looking at options."

## Daily Report Contents

The daily summary includes:
- **Top opportunities** (score 7+)
- **Trending topics** (recurring themes)
- **Recommended replies** (drafted, awaiting approval)
- **Follow-up reminders** (conversations to check back on)
- **Risky conversations** (avoid - complaints about specific brands, legal issues, etc.)

## Platform-Specific Notes

### Reddit
- Monitor r/cordcutters, r/YouTubeTV, r/Hulu, r/fuboTV, r/sports, r/NFL, r/MLB, r/NBA
- **CRITICAL:** Only engage with posts from last 14-21 days maximum
- Use search filters: `sort=new` and check post dates before responding
- Respect subreddit rules
- Check account age/karma requirements before posting

### Quora
- Focus on questions about streaming alternatives
- **Check question dates** - only answer questions from last 2-3 weeks
- Provide genuine value in answers

### YouTube Comments
- Monitor comments on streaming review videos
- **Check comment dates** - focus on videos/comments from last 14-21 days
- Look for frustrated users asking questions

### Discord
- Only public servers with explicit permission
- Never DM without consent
- Follow server-specific rules

## Rate Limits & Ethics

- Respect all platform rate limits
- Never scrape private content
- Always get human approval before posting
- When in doubt, skip the opportunity

## Files Reference

- `scripts/setup.sh` - Initial credential setup
- `scripts/scout.sh` - Run scans
- `scripts/review.sh` - Review opportunities
- `scripts/daily-report.sh` - Generate daily summary
- `references/apify-actors.md` - Apify actor configurations
- `references/cron-setup.md` - Automation setup guide
- `references/response-templates.md` - Response templates by scenario
- `assets/opportunity-schema.json` - Data schema for opportunities