#!/usr/bin/env bash

getGitSha() {
  stdout 'git rev-parse --short HEAD'
}

getLastCommitMessages(){
  stdout 'git log --oneline -n 5'
}

getLastCommitDateTime() {
  stdout 'git log --date=format:%y%m%d%H%M --format=%cd -n1'
}

releaseNotes() {
  stdout "Git hash: " + getGitSha + "\n\nLast changes: \n" + getLastCommitMessage + " \n\nLast change date: \n" + getLastCommitDateTime
}