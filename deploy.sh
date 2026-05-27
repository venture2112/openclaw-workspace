#!/bin/bash
# Deploy script for OpenClaw Workspace
# Run this script with your actual GitHub and Vercel tokens

set -e

echo "🚀 OpenClaw Workspace Deployment Script"
echo "========================================"

# Check if tokens are provided
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ Please set GITHUB_TOKEN environment variable"
    echo "   export GITHUB_TOKEN=ghp_your_token_here"
    exit 1
fi

if [ -z "$VERCEL_TOKEN" ]; then
    echo "❌ Please set VERCEL_TOKEN environment variable"
    echo "   export VERCEL_TOKEN=vcp_your_token_here"
    exit 1
fi

cd /root/.openclaw/workspace

# Configure git remote with token
echo "📡 Configuring GitHub remote..."
git remote set-url origin "https://Venture2112:${GITHUB_TOKEN}@github.com/Venture2112/openclaw-workspace.git"

# Create GitHub repo if it doesn't exist
echo "📦 Creating GitHub repository (if not exists)..."
curl -X POST \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  -d '{"name":"openclaw-workspace","description":"Venture Works Inc. OpenClaw workspace files","private":false}' \
  https://api.github.com/user/repos 2>/dev/null || true

# Push to GitHub
echo "⬆️  Pushing to GitHub..."
git push -u origin master

# Deploy to Vercel
echo "🌐 Deploying to Vercel..."
vercel --token "$VERCEL_TOKEN" --scope venture-works --prod --yes

echo ""
echo "✅ Deployment complete!"
echo "📁 GitHub Repo: https://github.com/Venture2112/openclaw-workspace"
