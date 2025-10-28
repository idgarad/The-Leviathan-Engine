#!/bin/bash
# GitLab to GitHub Mirror Sync Script
# Syncs main branch while excluding sensitive GitLab-specific files

set -e

GITLAB_REMOTE="origin"
GITHUB_REMOTE="github"
BRANCH="main"

echo "🔄 Starting GitLab to GitHub sync..."

# Ensure we're on the correct branch
git checkout $BRANCH
git pull $GITLAB_REMOTE $BRANCH

# Create temporary branch for GitHub sync
SYNC_BRANCH="github-sync-$(date +%s)"
git checkout -b $SYNC_BRANCH

# Remove GitLab-specific files that shouldn't be on GitHub
rm -f .gitlab-ci.yml
rm -rf infrastructure/terraform/secrets/
rm -rf infrastructure/ansible/vault/

# Add files back to git (in case they were tracked)
git add -A
git commit -m "Prepare for GitHub mirror sync - remove GitLab-specific files" || echo "No changes to commit"

# Push to GitHub
if git remote | grep -q "^$GITHUB_REMOTE$"; then
    echo "📤 Pushing to GitHub..."
    git push $GITHUB_REMOTE $SYNC_BRANCH:$BRANCH --force
    echo "✅ Successfully synced to GitHub"
else
    echo "❌ GitHub remote not configured. Run:"
    echo "   git remote add github https://github.com/idgarad/The-Leviathan-Engine.git"
    exit 1
fi

# Clean up
git checkout $BRANCH
git branch -D $SYNC_BRANCH

echo "🎉 GitHub sync complete!"
echo "   GitLab (Primary): Full project with CI/CD"
echo "   GitHub (Public):  Code visibility and community access"