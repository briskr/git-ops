!/usr/bin/env bash
echo "Make sure to commit your changes on 'develop' branch before commit release."
source ./bump-version.sh
current_version=$( mvn help:evaluate -Dexpression=project.version | grep -e '^[^\[]' )
git checkout -b release-${current_version} develop
echo "Switched to a temp branch 'release-${current_version}'."
echo "You can update CHANGELOG, but DO NOT change code."
echo "Please 'git push' after committing such changes, and notify project master to accept this release."
