#!/usr/bin/env bash
# generate release version number
source ./bump-version.sh
# publish local hotfix branch
current_branch=$( git br | grep '^*' | awk '{print $2}' )
git push -u origin $current_branch 
