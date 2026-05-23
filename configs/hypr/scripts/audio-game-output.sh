#!/usr/bin/env bash

QUIET="$1"

GAME_ID="$(wpctl status | awk '/Astro A50 Game/ {gsub(/\./,"",$2); print $2; exit}')"

if [ -n "$GAME_ID" ]; then
  wpctl set-default "$GAME_ID"
  wpctl set-volume "$GAME_ID" 55%
  [ "$QUIET" = "--quiet" ] || notify-send "Audio" "Output set to Astro A50 Game"
else
  [ "$QUIET" = "--quiet" ] || notify-send "Audio" "Astro A50 Game output not found"
fi
