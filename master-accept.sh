#!/usr/bin/env bash
# Usage: master-accept ( release-x.x | hotfix-x.x.x )
source_branch=$1

# fetch source branch content
git branch -f ${source_branch} origin/${source_branch}
git checkout ${source_branch}
git pull

# switch to master to accept changes
git checkout master
# in case master updated by others
git pull
# remember revision before taking in source branch
prev_rev=$( git log -n 1 --oneline | awk '{print $1}' )

git merge --no-ff ${source_branch}

suggested_version=$( mvn help:evaluate -Dexpression=project.version | grep -e ^[^\[] )
echo "This will accept suggested version ${suggested_version} from branch ${source_branch}."
read -p "Continue? (y/n) " userInput

if [[ "$userInput" = "y" ]]; then
  # publish merged status of master
  git push -u origin master
  # create and push tag
  git tag -a v${suggested_version} -m "Release ${suggested_version} (from branch ${source_branch})"
  git push origin v${suggested_version}
  # source branch no longer useful
  git push --delete origin ${source_branch}
  git branch -d ${source_branch}
else
  # revert to the revision before merge
  git reset --hard $prev_rev
fi
