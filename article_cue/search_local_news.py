#!/usr/bin/env python3
"""
Article Cue - Local News Search for Vista, San Marcos, Escondido
Searches for positive local stories and adds them to Control Board
"""

import json
import os
import sys
import requests
from datetime import datetime, timedelta
from urllib.parse import quote

# Config
CONFIG_PATH = "/root/.openclaw/workspace/article_cue/config.json"
ENV_PATH = "/root/.openclaw/workspace/.env.personal"

# Load config
with open(CONFIG_PATH, 'r') as f:
    config = json.load(f)

# Load credentials
credentials = {}
if os.path.exists(ENV_PATH):
    with open(ENV_PATH, 'r') as f:
        for line in f:
            if '=' in line and not line.startswith('#'):
                key, value = line.strip().split('=', 1)
                credentials[key] = value

CONTROLBOARD_API_TOKEN = credentials.get('CONTROLBOARD_API_TOKEN', '')
UNSPLASH_CLIENT_ID = credentials.get('UNSPLASH_CLIENT_ID', '')

if not CONTROLBOARD_API_TOKEN:
    print("❌ CONTROLBOARD_API_TOKEN not found in .env.personal")
    sys.exit(1)

# Control Board API base
CONTROLBOARD_URL = "https://control.clawlauncher.io/api"

# Positive keywords to include
POSITIVE_KEYWORDS = [
    "community", "celebrate", "achievement", "opening", "expansion", "growth",
    "donation", "charity", "help", "support", "award", "recognition",
    "new business", "hiring", "festival", "event", "success", "milestone",
    "partnership", "collaboration", "improvement", "progress", "victory",
    "graduate", "scholarship", "art", "culture", "sports win", "championship"
]

# Negative keywords to exclude
NEGATIVE_KEYWORDS = [
    "death", "killed", "murder", "shooting", "crash", "accident", "fire",
    "arrest", "crime", "theft", "robbery", "assault", "violence", "drugs",
    "overdose", "suicide", "attack", "stabbing", "gun", "weapon",
    "fatal", "injury", "hospitalized", "emergency", "tragedy", "disaster"
]

def search_brave(query, count=10):
    """Search using Brave API"""
    # Note: Using web_search via OpenClaw would be better, but we'll simulate with requests
    # For now, we'll use a simple approach - in production, integrate with Brave API
    
    headers = {
        "Accept": "application/json",
        "X-Subscription-Token": credentials.get('BRAVE_API_KEY', '')
    }
    
    url = f"https://api.search.brave.com/res/v1/news/search?q={quote(query)}&count={count}&freshness=day"
    
    try:
        response = requests.get(url, headers=headers, timeout=30)
        if response.status_code == 200:
            data = response.json()
            return data.get('results', [])
    except Exception as e:
        print(f"⚠️ Brave search error: {e}")
    
    return []

def search_news_api(query, count=10):
    """Fallback search using NewsAPI"""
    api_key = credentials.get('NEWSAPI_KEY', '')
    if not api_key:
        return []
    
    yesterday = (datetime.now() - timedelta(days=1)).strftime('%Y-%m-%d')
    url = f"https://newsapi.org/v2/everything?q={quote(query)}&from={yesterday}&sortBy=publishedAt&apiKey={api_key}&pageSize={count}"
    
    try:
        response = requests.get(url, timeout=30)
        if response.status_code == 200:
            data = response.json()
            return data.get('articles', [])
    except Exception as e:
        print(f"⚠️ NewsAPI error: {e}")
    
    return []

def is_positive_story(title, description):
    """Check if story is positive based on keywords"""
    text = f"{title} {description}".lower()
    
    # Check for negative keywords
    for neg in NEGATIVE_KEYWORDS:
        if neg in text:
            return False
    
    # Check for positive keywords
    for pos in POSITIVE_KEYWORDS:
        if pos in text:
            return True
    
    # Default to including if no red flags
    return True

def get_unsplash_image(query):
    """Get relevant image from Unsplash"""
    if not UNSPLASH_CLIENT_ID:
        return None
    
    try:
        url = f"https://api.unsplash.com/photos/random?query={quote(query)}&client_id={UNSPLASH_CLIENT_ID}"
        response = requests.get(url, timeout=10)
        if response.status_code == 200:
            data = response.json()
            return data.get('urls', {}).get('regular')
    except Exception as e:
        print(f"⚠️ Unsplash error: {e}")
    
    return None

def get_existing_articles():
    """Get existing articles from Control Board to avoid duplicates"""
    try:
        headers = {
            "Authorization": f"Bearer {CONTROLBOARD_API_TOKEN}",
            "X-Workspace-Id": config.get('controlboard_workspace_id', '')
        }
        
        response = requests.get(
            f"{CONTROLBOARD_URL}/articles",
            headers=headers,
            timeout=30
        )
        
        if response.status_code == 200:
            data = response.json()
            existing_urls = set()
            for article in data.get('articles', []):
                existing_urls.add(article.get('url', ''))
            return existing_urls
    except Exception as e:
        print(f"⚠️ Error fetching existing articles: {e}")
    
    return set()

def add_to_controlboard(article):
    """Add article to Control Board"""
    try:
        headers = {
            "Authorization": f"Bearer {CONTROLBOARD_API_TOKEN}",
            "X-Workspace-Id": config.get('controlboard_workspace_id', ''),
            "Content-Type": "application/json"
        }
        
        payload = {
            "title": article['title'],
            "url": article['url'],
            "imageUrl": article.get('imageUrl', ''),
            "description": article.get('description', ''),
            "source": article.get('source', 'Unknown'),
            "status": "pending_review",
            "location": article.get('location', '')
        }
        
        response = requests.post(
            f"{CONTROLBOARD_URL}/articles/add",
            headers=headers,
            json=payload,
            timeout=30
        )
        
        return response.status_code == 200
    except Exception as e:
        print(f"⚠️ Error adding article: {e}")
        return False

def main():
    print("🔍 Starting local news search...")
    print(f"📅 {datetime.now().strftime('%Y-%m-%d %H:%M:%S PT')}")
    
    # Get existing articles to avoid duplicates
    existing_urls = get_existing_articles()
    print(f"📚 Found {len(existing_urls)} existing articles")
    
    locations = config.get('locations', [])
    articles_per_location = config.get('articles_per_location', 2)
    
    total_added = 0
    
    for location in locations:
        print(f"\n📍 Searching: {location}")
        
        # Build search query for positive stories
        query = f"{location} { ' OR '.join(POSITIVE_KEYWORDS[:5]) }"
        
        # Try Brave API first
        results = search_brave(query, count=10)
        
        # Fallback to NewsAPI if needed
        if not results:
            results = search_news_api(query, count=10)
        
        added_for_location = 0
        
        for result in results:
            if added_for_location >= articles_per_location:
                break
            
            # Extract article data
            title = result.get('title', '')
            url = result.get('url', '') or result.get('link', '')
            description = result.get('description', '') or result.get('snippet', '')
            source = result.get('source', 'Unknown')
            
            # Skip if already exists
            if url in existing_urls:
                print(f"  ⏭️ Skipping duplicate: {title[:50]}...")
                continue
            
            # Check if positive story
            if not is_positive_story(title, description):
                print(f"  ⏭️ Skipping negative story: {title[:50]}...")
                continue
            
            # Get Unsplash image
            image_query = f"{location} community"
            image_url = get_unsplash_image(image_query)
            
            article = {
                'title': title,
                'url': url,
                'description': description,
                'source': source,
                'imageUrl': image_url or result.get('image', ''),
                'location': location
            }
            
            if add_to_controlboard(article):
                print(f"  ✅ Added: {title[:60]}...")
                total_added += 1
                added_for_location += 1
                existing_urls.add(url)
            else:
                print(f"  ❌ Failed to add: {title[:50]}...")
        
        print(f"  📊 Added {added_for_location} articles for {location}")
    
    print(f"\n✅ Complete! Added {total_added} new articles total")
    return total_added

if __name__ == "__main__":
    main()
