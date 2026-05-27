# Recent Content Filtering Guide

## CRITICAL RULE: Only Engage with Recent Posts

**Maximum Age:** 14-21 days (2-3 weeks)
**Target:** 1-7 days for best engagement
**Never engage with:** Posts older than 30 days

---

## Why This Matters

- Old posts = dead conversations = wasted effort
- Users won't see your response
- Looks spammy to moderators
- Hurts your account reputation

---

## Platform-Specific Date Checking

### Reddit

**How to Check Post Age:**
1. Look at timestamp next to post title (e.g., "2 days ago", "15 hours ago")
2. Click post to see exact date in comments
3. Use Reddit search with "past week" filter:
   ```
   https://www.reddit.com/r/cordcutters/search/?q=YouTube+TV&sort=new&t=week
   ```

**URL Parameters for Recent Content:**
- `&sort=new` - Sort by newest first
- `&t=day` - Last 24 hours
- `&t=week` - Last 7 days
- `&t=month` - Last 30 days (use sparingly)

**Red Flags - Skip These:**
- "Posted 3 months ago"
- "Posted 1 year ago"
- Archived posts (can't comment anyway)

---

### Twitter/X

**How to Check Tweet Age:**
1. Timestamp is shown on every tweet
2. Hover over timestamp for exact date/time

**Search Filters:**
- Use "Latest" tab for real-time results
- Add `within_time:7d` to search (if using advanced search)

**URL for Recent Tweets:**
```
https://twitter.com/search?q=YouTube+TV+cancel&f=live
```

**Red Flags - Skip These:**
- Tweets older than 2 weeks
- Quote tweets of old posts
- Retweets from months ago

---

### Quora

**How to Check Question Age:**
1. Scroll to bottom of question
2. Look for "Asked [date]" 
3. Check when most recent answer was posted

**Red Flags - Skip These:**
- Questions from 2023 or earlier
- Questions with no activity in 30+ days
- Questions already answered 50+ times

---

### Forums (AVS, DSLReports, NeoGAF, ResetEra)

**How to Check Thread Age:**
1. Look at "Last post" date in thread list
2. Check first post date vs recent replies
3. Look for thread activity indicators

**Red Flags - Skip These:**
- Threads with last post 30+ days ago
- "Necro" threads (old threads bumped recently)
- Stickied/announcement threads

---

## Automated Date Filtering

### Using Apify for Reddit

When using Apify Reddit scrapers, add these parameters:

```json
{
  "sort": "new",
  "time": "week",
  "maxItems": 50
}
```

### Using Brave Search

Add date filters to queries:
- `after:2026-05-01` (Google-style, may not work reliably)
- Use site-specific date filters instead

---

## Manual Verification Checklist

Before responding to ANY post:

- [ ] Post is less than 21 days old
- [ ] Thread is still active (recent comments)
- [ ] User is still active (check profile)
- [ ] Not a repost/bot account
- [ ] Conversation is still relevant

---

## Tools for Date Checking

1. **Reddit:** RES (Reddit Enhancement Suite) shows exact timestamps
2. **Twitter:** Built-in timestamps + "Latest" filter
3. **Quora:** Scroll to question footer for date
4. **Forums:** Usually show post dates clearly

---

## Common Mistakes

❌ **Don't:** Sort by "Top" and respond to old popular posts
✅ **Do:** Sort by "New" and find recent discussions

❌ **Don't:** Use general search without date filters
✅ **Do:** Use platform-specific recent content filters

❌ **Don't:** Trust search engine "published" dates
✅ **Do:** Verify actual post date on the platform

---

## Daily Monitoring Workflow

1. **Morning Check (15 mins):**
   - Reddit: r/cordcutters sorted by "new" (past 24h)
   - Twitter: Search "YouTube TV cancel" (latest)
   - Quora: Search cable alternatives (past week)

2. **Afternoon Check (10 mins):**
   - Check replies to your morning responses
   - Look for new threads
   - Update tracking spreadsheet

3. **Evening Review (5 mins):**
   - Note successful engagements
   - Plan tomorrow's targets
   - Log any issues

---

## Date Tracking Template

| Platform | Thread/Post URL | Post Date | Your Response Date | Status |
|----------|----------------|-----------|-------------------|--------|
| Reddit | ... | 2026-05-20 | 2026-05-21 | Active |
| Twitter | ... | 2026-05-19 | 2026-05-21 | Replied |

---

**Remember: Fresh content = better engagement = higher conversion**
