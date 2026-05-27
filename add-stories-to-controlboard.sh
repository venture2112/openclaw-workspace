#!/bin/bash

TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2YTBiYzI3ODM0ZWZiMGI0YmQ1MjFkMGIiLCJlbWFpbCI6ImNhcmFAdmVudHVyZXdvcmtzaW5jLmNvbSIsInJvbGVzIjpbIkJBU0lDIl0sInJlcXVpcmVQYXNzd29yZENoYW5nZSI6ZmFsc2UsImtleSI6ImI0N2VjYzdkN2RlZWNiZGMxMTE4YmM2NWQwYjAzMWI0IiwiaWQiOiI2YTBiZDRmYTM0ZWZiMGI0YmQ1MjFkMTUiLCJwbGF0Zm9ybSI6IkFQUCIsImlhdCI6MTc3OTE2MDMxNCwiZXhwIjoxODEwNjk2MzE0fQ.f4X034MI5rEU2SpxiG3uhVZQQ3efgPXOwe8Z19pFadU"
WORKSPACE="6a1219a934efb0b4bd5220af"
API_URL="https://control.clawlauncher.io/api/articles/add"

add_article() {
  curl -s -X POST "$API_URL" \
    -H "Authorization: Bearer $TOKEN" \
    -H "X-Workspace-Id: $WORKSPACE" \
    -H "Content-Type: application/json" \
    -d "$1"
  echo ""
}

# VISTA STORIES
echo "Adding Vista stories..."

add_article '{
  "title": "Vista Public Works Week Open House Features Vehicle Showcase",
  "url": "https://www.thevistapress.com/city-of-vista-news-headlines-20/",
  "imageUrl": "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=800",
  "description": "The Public Works Department invites the community to a FREE open house featuring a vehicle and equipment showcase, and a meet-and-greet with Vista Public Works staff during National Public Works Week.",
  "source": "The Vista Press"
}'

add_article '{
  "title": "Fire Crews Halt Forward Spread of 3-Acre Vegetation Fire in Vista",
  "url": "https://www.cbs8.com/article/news/local/wildfire/fire-crews-battle-vegetation-fire-in-vista/509-aa6b5cdb-be10-45e9-a8ad-0fcc4562255d",
  "imageUrl": "https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?w=800",
  "description": "Fire crews stopped the forward rate of spread on a vegetation fire in Vista on May 7, 2026. The three-acre fire in the 2900 block of Fairview Drive prompted road closures.",
  "source": "CBS 8 San Diego"
}'

add_article '{
  "title": "37 Vista Students Recognized as Rising Stars of the Year",
  "url": "https://www.thevistapress.com/velocity-news-159/",
  "imageUrl": "https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=800",
  "description": "37 students were recognized at the Rising Star awards ceremony on May 11, 2026, celebrating academic achievement and community involvement.",
  "source": "The Vista Press"
}'

add_article '{
  "title": "Vista DUI Checkpoint Results Released from May 9 Operation",
  "url": "https://www.sdsheriff.gov/bureaus/media-relations/news-release",
  "imageUrl": "https://images.unsplash.com/photo-1557682268-e3955ed5d83f?w=800",
  "description": "San Diego County Sheriff's Department conducted a DUI checkpoint in Vista on May 9, 2026 as part of ongoing traffic safety enforcement.",
  "source": "San Diego County Sheriff"
}'

add_article '{
  "title": "New Cugini's Italian Kitchen Opens at Former New Hope Star Diner Location",
  "url": "https://vista.today/2026/04/cuginis-italian-kitchen-opening/",
  "imageUrl": "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800",
  "description": "A new Sicilian restaurant, Cugini's Italian Kitchen, has opened at the former New Hope Star Diner location, offering authentic Italian menu options.",
  "source": "Vista Today"
}'

add_article '{
  "title": "Vista City Council to Hold Public Meeting on Zone Change Proposal",
  "url": "https://www.thevistapress.com/south-vista-communities-may-26-newsletter/",
  "imageUrl": "https://images.unsplash.com/photo-1555848962-6e79363ec58f?w=800",
  "description": "City Council will hold a public meeting on May 26, 2026 at 5:30 PM to discuss a proposal for a Zone Change affecting approximately 3 acres on the west side of La Tortuga.",
  "source": "The Vista Press"
}'

add_article '{
  "title": "Vista Fire Reported in Orange County on May 9",
  "url": "https://www.fresnobee.com/news/california/fires/article315699145.html",
  "imageUrl": "https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?w=800",
  "description": "A wildfire named Vista Fire was reported on May 9, 2026 at 3:13 p.m. burning on private land in Orange County. Containment status and cause remain under investigation.",
  "source": "Fresno Bee"
}'

echo "Vista stories added!"
