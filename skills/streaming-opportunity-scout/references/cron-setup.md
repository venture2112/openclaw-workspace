# Cron Setup Guide

## Automated Daily Monitoring

Add to your crontab for daily scans:

```bash
# Edit crontab
crontab -e

# Add these lines:

# Daily scan at 9 AM
0 9 * * * /path/to/skills/streaming-opportunity-scout/scripts/scout.sh --platform reddit --keywords "cord cutting" --limit 50

# Daily scan at 9:30 AM
30 9 * * * /path/to/skills/streaming-opportunity-scout/scripts/scout.sh --platform reddit --keywords "YouTube TV price" --limit 50

# Daily scan at 10 AM
0 10 * * * /path/to/skills/streaming-opportunity-scout/scripts/scout.sh --platform reddit --keywords "NFL streaming cheap" --limit 50

# Generate daily report at 11 AM
0 11 * * * /path/to/skills/streaming-opportunity-scout/scripts/daily-report.sh
```

## Keyword Rotation

Create a keywords file and rotate through them:

```bash
# keywords.txt
cord cutting
cable alternatives
YouTube TV price increase
Hulu Live vs
cheap sports streaming
FuboTV alternatives
MLB streaming 2025
NBA streaming without cable
UFC streaming options
streaming service costs
```

## Weekly Deep Dive

```bash
# Sundays - comprehensive scan
0 10 * * 0 /path/to/skills/streaming-opportunity-scout/scripts/scout.sh --platform all --keywords "cord cutting" --limit 100
```

## Notification Options

### Email Report
```bash
0 11 * * * /path/to/scripts/daily-report.sh && cat /path/to/data/$(date +\%Y-\%m-\%d)/daily-report.md | mail -s "Daily Streaming Scout Report" your@email.com
```

### Slack Notification
```bash
0 11 * * * /path/to/scripts/daily-report.sh && curl -X POST -H 'Content-type: application/json' --data '{"text":"Daily streaming scout report ready"}' YOUR_SLACK_WEBHOOK
```

## Log Rotation

Logs are stored in `~/.streaming-scout/logs/`. Set up rotation:

```bash
# Add to /etc/logrotate.d/streaming-scout
~/.streaming-scout/logs/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
}
```