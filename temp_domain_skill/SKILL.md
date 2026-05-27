---
name: domain-name-finder
description: Discover available domain names for business ideas by generating domain suggestions and checking availability via DNS lookups. Use when the user asks to find domain names, check domain availability, or uses the /domainname command. Helps users brainstorm and validate domain names for their projects, marketplaces, or products. No API keys required.
---

# Domain Name Finder

Generate brandable domain names and check their availability via DNS lookups.

## Trigger

When the user types `/domainname` or asks to find/check domain names.

## Workflow

### Step 1: Gather Requirements

Ask: **"What is your idea, marketplace, or product?"**

Example response: "Growing Giant Zucchinis"

### Step 2: Quantity

Ask: **"How many domain suggestions would you like generated?"**

Example response: "100"

### Step 3: Generate Names

Create domain name ideas based on the topic using these strategies:

- **Short & brandable**: zucchinimagic, growzini, giantzini
- **Keyword combinations**: growgiantzucchini, giantzucchinihub
- **Descriptive**: zucchinikingdom, giantzucchinigarden
- **Marketplace style**: zucchinigiants, monsterzucchinihub
- **Action-oriented**: growmonsterzucchini

**Guidelines:**
- Keep names short and memorable
- Avoid hyphens when possible
- Avoid numbers unless necessary
- Prioritize readability

Generate at least 2x the requested quantity to account for unavailable domains.

### Step 4: Check Availability

For EVERY generated domain, check these extensions:
- `.com`
- `.net`
- `.org`

Use the DNS lookup script: `scripts/check-domains-dns.js`

This method uses DNS resolution to check if domains are registered - no API keys required!

### Step 5: Filter & Present

**ONLY show available domains.** Do not display taken domains.

**Output format:**

```
Available Domains Found:

growgiantzucchini.com
giantzucchinimagic.com
monsterzucchinihub.net
zucchinikings.org
giantzucchinigarden.com
```

Prioritize `.com` domains at the top of the list.

### Step 6: Continue if Needed

If fewer available domains than requested were found, automatically:
1. Generate more domain ideas
2. Check availability
3. Add to results

Repeat until the requested quantity is reached or a reasonable maximum is attempted (3x the requested quantity).

## How It Works

This skill uses **DNS lookups** to check domain availability - no API keys or authentication required!

The script (`scripts/check-domains-dns.js`) checks if a domain resolves via DNS:
- If DNS resolution fails (ENOTFOUND), the domain is likely available
- If DNS resolves successfully, the domain is registered

This method is:
- ✅ Fast (checks multiple domains concurrently)
- ✅ Free (no API costs)
- ✅ Simple (no authentication needed)
- ⚠️ Note: Not 100% accurate - always verify before purchasing

## Notes

- This skill operates in batch mode - it generates and checks domains in bulk
- Results are filtered to only show available domains
- The skill automatically continues generating if initial results are insufficient
