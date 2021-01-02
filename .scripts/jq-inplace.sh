#!/bin/sh

# The first argument should be json string that would be fed into jq.
# The second argument should be json filename.

# create temporary file
TEMP=$(mktemp)

# remove temoorary file in case the program terminates unexpectedly
trap "{ rm -f $TEMP; }" EXIT

# redirect the result of jq [FIRST ARG] [SECOND ARG] to temporary file
jq "$1" "$2" > $TEMP

# replace original json with new one
cat $TEMP > "$2"

# remove used temporary file
rm $TEMP
