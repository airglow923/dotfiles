#!/bin/sh

COMMAND=""

usage() {
  # additional error messages
  if [ "$#" -ne 0 ]; then
    printf "$@\n" >&2;
  fi

  printf "Usage: $0 LATEX\n" >&2;
}

if [ "$#" -eq 0 ]; then
  usage
  exit 1;
fi

if command -v deno > /dev/null; then
  COMMAND="deno run deno-to-latex-uri.js"
elif command -v node > /dev/null; then
  COMMAND="node node-to-latex-uri.js"
else
  usage "No JavaScript runtime found"
  exit 1;
fi

$COMMAND "$1"
