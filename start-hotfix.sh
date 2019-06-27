#!/usr/bin/env bash
# Usage: ./start-hotfix.sh ( <issue name> | <bug #> )
print_usage() {
  echo "Usage: ./start-hotfix.sh ( <issue name> | <bug #> )"
}

if [[ -z "$1" ]]; then
  echo "hotfix name needed."
  print_usage
  exit 1
fi

name=$1
git checkout -b hotfix-${name} master
echo "Switched to branch hotfix-${name}. You can begin composing fix."
echo "Please run './submit-hotfix.sh' after committing changes, and notify master to merge branch."
