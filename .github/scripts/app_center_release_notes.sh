#!/usr/bin/env bash

getGitSha() {
  git rev-parse --short HEAD
}

getLastCommitMessages(){
  git log --oneline -n 5
}

getLastCommitDateTime() {
 git log --date=format:'Date: %d/%m/%y, Time: %H:%M:%S' --format=%cd -n1
}

releaseNotes() {
  printf "$(getLastCommitMessages)"

}

case "$1" in
    "") ;;
    releaseNotes) "$@"; exit;;
    *) log_error "Unknown function: $1()"; exit 2;;
esac