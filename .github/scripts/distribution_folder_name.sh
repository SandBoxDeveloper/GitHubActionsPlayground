#!/bin/bash

$FEATURE_BRANCH_NAME

while getopts b: flag
do
    case "${flag}" in
        b) FEATURE_BRANCH_NAME=${OPTARG};;
        *) echo "usage: $0 invalid flag used. Please use flag: -b"
        exit 1 ;;
    esac
done

# feature/instant_credentials/master -> instant_credentials
# feature/FIREFLY-2345_something -> don't push build to this folder
# fix/FIREFLY_2345_something -> don't push build to this folder
# chore/FIREFLY_2345_something -> don't push build to this folder
# master


# feature/FIREFLY-2345_something going to feature/instant_credentials/main-> instant_credentials
# fix/FIREFLY_2345_something going to feature/instant_credentials/main -> instant_credentials
# chore/FIREFLY_2345_something  going to feature/instant_credentials/main -> instant_credentials

if [ "$FEATURE_BRANCH_NAME" == "refs/heads/main" ]
then
  echo "feature branch matches main"
  # this deletes everything from the left side up till / and keeps the right hand side
  # refs/heads/main -> main
  echo "${FEATURE_BRANCH_NAME##*/}"
else
  branch_ref="${FEATURE_BRANCH_NAME%/*}"
  echo "branch does not match main"
  echo "1st... ${branch_ref}"
  echo "${FEATURE_BRANCH_NAME##*/}"

  # this starts from the end of the ref
  # and moving left, deletes everything up till the first /
  # keeping everything to the left of it
  # refs/heads/feature/instant_credentials/master -> refs/heads/feature/instant_credentials
  new_folder="${FEATURE_BRANCH_NAME%/*/}"
  echo "first chop: ${new_folder}"
  # this kicks off from the beginning of the ref, moving right
  # moving right, deletes everything till the last /
  # keeping everything to the right of it
  # refs/heads/feature/instant_credentials -> instant_credentials
  echo "second chop: ${new_folder#*/}"
fi