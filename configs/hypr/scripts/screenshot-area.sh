#!/usr/bin/env bash

mkdir -p "$HOME/Pictures/Screenshots"

FILE="$HOME/Pictures/Screenshots/screenshot-area-$(date +%Y-%m-%d_%H-%M-%S).png"

grim -g "$(slurp)" "$FILE" || exit 0

swappy -f "$FILE" -o "$FILE"

wl-copy < "$FILE"
notify-send "Screenshot saved + copied" "$FILE"
