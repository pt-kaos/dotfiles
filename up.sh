#!/bin/bash
set -eo pipefail
##################################################################################################################
# Author    : Pedro Teodoro
# Github    : https://github.com/pt-kaos
##################################################################################################################
#tput setaf Colors:
#     0 = black
#     1 = red
#     2 = green
#     3 = yellow
#     4 = darkblue
#     5 = purple
#     6 = cyan
#     7 = gray
#     8 = lightblue
##################################################################################################################

tput setaf 6
echo "=============================================================="
echo "                    Updating $(basename $(pwd))"
echo "=============================================================="
tput sgr0

message="New update"

while getopts ":m:" opt; do
  case ${opt} in
    m )
      if [[ -n "$OPTARG" ]]; then
        message="$OPTARG"
      fi
      ;;
    \? )
      echo "Usage: $0 [-m <message>]"
      exit 1
      ;;
  esac
done

echo "====> git update <===="

git add --all .                           # Add every change to be pushed to git
git commit -m "$message"                  # Commit to local repository with a default message
branch=$(git rev-parse --abbrev-ref HEAD) # Get branch name origin or master
git push -u origin "$branch"              # Push the local files to github

tput setaf 6
echo "=============================================================="
echo "                    $(basename $0) done"
echo "=============================================================="
tput sgr0
