#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"

if ! command -v cliphist >/dev/null 2>&1; then
  notify-send "Clipboard" "cliphist is not installed"
  exit 1
fi

choice="$(cliphist list | rofi -dmenu -i -p "Clipboard" -theme "$THEME")"

[ -z "$choice" ] && exit 0

printf "%s" "$choice" | cliphist decode | wl-copy
notify-send "Clipboard copied" "Selected item copied back to clipboard"
