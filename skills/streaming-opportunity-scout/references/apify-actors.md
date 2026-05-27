# Apify Actor Reference

## Recommended Actors for Streaming Opportunity Scout

### Reddit Monitoring

**Actor:** `trudax/reddit-scraper`
**Use case:** Search Reddit posts and comments

**Input parameters:**
```json
{
    "searches": ["cable alternatives", "cord cutting"],
    "maxResults": 50,
    "sort": "new",
    "time": "day"
}
```

**Output fields:**
- `title` - Post title
- `text` - Post/comment text
- `author` - Username
- `subreddit` - Source subreddit
- `url` - Permalink
- `created_utc` - Timestamp
- `score` - Upvotes

### YouTube Comments

**Actor:** `youtube-comments-scraper` (find on Apify Store)
**Use case:** Monitor comments on streaming-related videos

**Search strategy:**
- Target videos about: "YouTube TV review", "best streaming service", "cord cutting guide"
- Monitor comments for frustration/questions

### Quora

**Actor:** `quora-scraper` (find on Apify Store)
**Use case:** Find questions about streaming alternatives

### Generic Web Scraper

**Actor:** `apify/web-scraper`
**Use case:** Custom forum monitoring

## Apify API Reference

### Start a Run
```bash
curl -X POST "https://api.apify.com/v2/acts/{ACTOR_ID}/runs?token={API_TOKEN}" \
    -H "Content-Type: application/json" \
    -d '{"input": "parameters"}'
```

### Check Run Status
```bash
curl "https://api.apify.com/v2/actor-runs/{RUN_ID}?token={API_TOKEN}"
```

### Get Results
```bash
curl "https://api.apify.com/v2/datasets/{DATASET_ID}/items?token={API_TOKEN}&format=json"
```

## Rate Limits

- Default: 10 requests per second
- Monitor your usage at: https://console.apify.com/billing

## Cost Considerations

- Reddit scraper: ~$0.25 per 1000 posts
- YouTube comments: Variable based on video count
- Set up billing alerts to avoid surprises