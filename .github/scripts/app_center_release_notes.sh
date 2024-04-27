#!/usr/bin/env bash

# Grant executable permissions to the script
chmod +x "$0"

getGitSha() {
  git rev-parse --short HEAD
}

getLastCommitMessages() {
  git log --pretty=format:'* %h %s' -n 5
}

getLastCommitDateTime() {
  git log --date=format:'Date: %d/%m/%y, Time: %H:%M:%S' --format=%cd -n1
}

releaseNotes() {
  printf "### Git hash 👾: \n%s \n\n### Latest commits in this build 🧑🏾‍💻: \n%s \n\n#### Last commit date 📆 :\n%s " "$(getGitSha)" "$(getLastCommitMessages)" "$(getLastCommitDateTime)"
}

case "$1" in
  "") ;;
  releaseNotes) "$@"; exit;;
  *) log_error "Unknown function: $1()"; exit 2;;
esac