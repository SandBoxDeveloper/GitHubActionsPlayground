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

if [ "$FEATURE_BRANCH_NAME" == "ref/head/master" ]; then
  echo "${FEATURE_BRANCH_NAME##*/}"
else
  branch_ref="${FEATURE_BRANCH_NAME%/*}"
  echo "${branch_ref##*/}"
fi