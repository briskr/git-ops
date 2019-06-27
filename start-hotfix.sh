#!/usr/bin/env bash
# Usage: ./start-hotfix.sh ( <issue name> | <bug #> )
name=$1
git checkout -b hotfix-${name} master
echo "Switched to branch hotfix-${name}. You can begin composing fix."
echo "Please run './submit-hotfix.sh' after committing changes, and notify master to merge branch."
