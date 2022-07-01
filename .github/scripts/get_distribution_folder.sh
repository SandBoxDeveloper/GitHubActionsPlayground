#!/bin/bash

$BRANCH_REF

while getopts b: flag
do
    case "${flag}" in
        b) BRANCH_REF=${OPTARG};;
        *) echo "usage: $0 invalid flag used. Please use flag: -b"
        exit 1 ;;
    esac
done

# This removes the described pattern
# by matching it from the end of the branch name.
# The operator "%" will try to remove the shortest text
# matching the pattern.
# e.g refs/heads/feature/some_branch_name/master
# becomes -> refs/heads/feature/some_branch_name/

# while "##" will try to remove the described pattern with
# by matching it from the start of the branch name.
# It will remove the longest text matching the pattern.
# e.g refs/heads/feature/some_branch_name/
# becomes -> feature/some_branch_name/

if [ "$BRANCH_REF" == "ref/head/main" ]
then
  echo "${BRANCH_REF##*/}"
else
  branch_ref="${BRANCH_REF%/*}"
  echo "${branch_ref##*/}"
fi