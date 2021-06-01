#!/bin/sh

usage() {
  # additional error messages
  if [ "$#" -ne 0 ]; then
    printf "$@\n" >&2;
  fi

  printf "Usage: $0 ALGORITHM JS_FILE\n" >&2;
}

if [ "${#@}" -eq 0 ]; then
  usage
  exit 1;
fi

ALGORITHM="$1"
FILE="$2"

BINARY=$(openssl dgst -"$ALGORITHM" -binary "$FILE")

if [ $? -ne 0 ]; then
  usage
  exit 1;
fi

INTEGRITY=$(echo -n "$BINARY" | openssl base64 -A)

echo "$ALGORITHM-$INTEGRITY"
