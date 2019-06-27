#!/usr/bin/env bash
# Update project.version in pom.xml, and commit
major=1
minor=0
build=$( date +%-m%d )
target_version=$major.$minor.$build

echo "This will change project.version in pom.xml to ${target_version}."
read -p "Continue? (y/n) " userInput
echo

if [[ "$userInput" = "y" ]]; then
 mvn versions:set -q -DgenerateBackupPoms=false -DnewVersion=${target_version}
 #mvn versions:revert -q
 git commit -a -m "Bumped version number to ${target_version}"
 echo "Committed the version change to local git repo."
else
 echo "Version change cancelled."
fi
