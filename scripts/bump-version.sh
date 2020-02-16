#!/bin/sh

get_version()
{
  # Echoes the version from the file “package.json”.
  echo `cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed "s/[\",]//g" | tr -d "[[:space:]]"`
}

# Changes into the directory “flutter-tfl-api-explorer”.
cd "$GITHUB_WORKSPACE/flutter-tfl-api-explorer"

# Creates a branch name in the format “bump-1580201010”.
BRANCH="bump-`date '+%s'`"
# Checks out a branch with the name “bump-1580201010”.
git checkout -b "$BRANCH"

# Gets the current version.
CURRENT_VERSION=`get_version`
# Bumps the version and updates the changelog.
npx beachball bump
# Gets the bumped version.
VERSION=`get_version`

# If the versions are not equal, then update the version in files.
if [ "$CURRENT_VERSION" != "$VERSION" ]; then
  # Replaces the version in the file “pubspec.yaml”.
  sed -i -e "s/version: .*/version: $VERSION/g" pubspec.yaml
fi

# Adds all the changed files to git.
git add --all
# Commits all the changed files.
git commit --message "release: cut the v$VERSION release [skip ci]"

# If the versions are not equal, then tag the version in git.
if [ "$CURRENT_VERSION" != "$VERSION" ]; then
  # Tags the commit in the format “tfl-api-explorer_v1.0.0”.
  git tag --annotate "tfl-api-explorer_v$VERSION" --message "tfl-api-explorer v$VERSION"
fi

# Pushes the commit and the tag to the remote.
git push --follow-tags origin HEAD:"$BRANCH"
# Checks out the branch “master”.
git checkout master
# Pulls the branch “master”.
git pull origin master
# Merges the branch “bump-1580201010” into the branch “master”.
git merge --no-edit "$BRANCH"
# Pushes the commit and the tag to the remote.
git push --follow-tags origin master
# Deletes the branch “bump-1580201010”.
git branch --delete "$BRANCH"
# Deletes the branch “bump-1580201010” on the remote.
git push --delete origin "$BRANCH"
