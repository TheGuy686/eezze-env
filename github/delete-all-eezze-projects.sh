#!/bin/bash

# WARNING: This script will permanently delete all repositories in the given GitHub account.
# Use with extreme caution.

# GitHub username
GITHUB_USERNAME="eezze-projects"

# Fetch list of repositories (names only)
repos=$(gh repo list $GITHUB_USERNAME --limit 1000 --json name -q ".[].name")

# Confirmation
read -p "Are you sure you want to delete ALL repositories in the GitHub account '$GITHUB_USERNAME'? [y/N] " confirmation
if [ "$confirmation" != "y" ]; then
  echo "Operation cancelled."
  exit 1
fi

# Loop through and delete each repository
for repo in $repos; do
    echo "Deleting repository: $repo"
    gh repo delete "$GITHUB_USERNAME/$repo" --confirm
done

echo "All repositories have been deleted."
