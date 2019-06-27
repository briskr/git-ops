#!/usr/bin/env bash
# Usage: master-accept ( release-x.x | hotfix-x.x.x )
source_branch=$1

git checkout master

# remember previous revision
prev_rev=$( git log -n 1 --oneline | awk '{print $1}' )

git merge --no-ff ${source_branch}

suggested_version=$( mvn help:evaluate -Dexpression=project.version | grep -e ^[^\[] )
echo "This will accept suggested version ${suggested_version} from branch ${source_branch}."
read -p "Continue? (y/n) " userInput

if [[ "$userInput" = "y" ]]; then
  # push merged tree of master branch
  git push
  # create and push tag
  git tag -a v${suggested_version} -m "Release ${suggested_version} (from branch ${source_branch})"
  git push origin v${suggested_version}
else
  # revert to the revision before merge
  git reset --hard $prev_rev
fi
