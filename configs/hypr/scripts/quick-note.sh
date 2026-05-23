#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"
FILE="$HOME/Documents/Aetherelic/quick-notes.md"

note="$(rofi -dmenu -p "Quick note" -theme "$THEME")"
[ -z "$note" ] && exit 0

{
  echo
  echo "## $(date '+%Y-%m-%d %H:%M')"
  echo "$note"
} >> "$FILE"

notify-send "Note saved" "$note"
