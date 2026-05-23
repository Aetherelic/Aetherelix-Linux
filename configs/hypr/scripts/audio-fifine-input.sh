#!/usr/bin/env bash

QUIET="$1"

MIC_ID="$(wpctl status | awk '/fifine Microphone Mono/ {gsub(/\./,"",$2); print $2; exit}')"

if [ -n "$MIC_ID" ]; then
  wpctl set-default "$MIC_ID"
  wpctl set-volume "$MIC_ID" 100%
  [ "$QUIET" = "--quiet" ] || notify-send "Audio" "Input set to Fifine Microphone"
else
  [ "$QUIET" = "--quiet" ] || notify-send "Audio" "Fifine microphone not found"
fi
