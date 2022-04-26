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

printStart(){
  start_feature=$1
  end=$2
  branch=$3

  echo "start feature: $start_feature"
  echo "end: $end"

  if [[ ("$start_feature" == "refs/heads/feature/") && "$end" == "main" ]];
  then
    branch_ref=${branch##*/feature/}
    feature_name=${branch_ref%/main*}
    echo "firefly-${feature_name}"
  else
    echo "you're not deploying to a feature branch of type \"feature/x/master\" ! - Please check where you're merging to."
  fi
}

if [ "$FEATURE_BRANCH_NAME" == "refs/heads/main" ]
then
  # this deletes everything from the left side up till / and keeps the right hand side
  # refs/heads/main -> main
  echo "firefly-master"
else
  # feature branch
  feature_branch_start="${FEATURE_BRANCH_NAME%feature*}"

  # end of any branch
  feature_branch_end="${FEATURE_BRANCH_NAME##**/}"

  echo "branch: $FEATURE_BRANCH_NAME"
  echo "feature branch: $feature_branch_start"

  printStart "$feature_branch_start" "$feature_branch_end" "$FEATURE_BRANCH_NAME"
fi