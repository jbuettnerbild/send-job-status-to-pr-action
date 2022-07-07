#!/bin/sh -l

state=$1
target_url=$2
description=$3
context=$4
repository=$5
github_token=$6
sha=$7

PAYLOAD="{\"state\":\"$state\",\"target_url\":\"$target_url\",\"description\":\"$description\",\"context\":\"$context\"}"
curl -i -X POST -H "Accept: application/vnd.github+json" -H "authorization: Bearer $github_token" -d "$PAYLOAD" https://api.github.com/repos/$repository/statuses/$sha
