#!/bin/bash

TMUX_UNATTACHED=$(tmux ls | grep -E -v '\(attached\)$')
while read session; do
  tmux kill-session -t "${line%%:*}"
done <<< $TMUX_UNATTACHED
