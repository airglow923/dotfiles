#!/bin/sh

FILE1=$1
FILE2=$2

output_error() {
  echo "$1"
  1>&2;
  exit 1;
}

usage() {
  output_error "Usage: $0 [FILE1] [FILE2]"
}

file_not_found() {
  output_error "File \"$1\" not found."
}

if [ "$#" -ne 2 ]; then
  usage
fi

if [ ! -f "$FILE1" ]; then
  file_not_found $FILE1
fi

if [ ! -f "$FILE2" ]; then
  file_not_found $FILE2
fi

# create temporary file
TEMP=$(mktemp)

# remove temporary file upon interruption
trap "{ rm -f $TEMP; }" EXIT

# move FILE1 to temporary file
mv $FILE1 $TEMP

# move FILE2 to FILE1
mv $FILE2 $FILE1

# move FILE1 to FILE2
mv $TEMP $FILE2
