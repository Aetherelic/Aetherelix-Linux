#!/usr/bin/env bash

mkdir -p "$HOME/Pictures/Screenshots"

FILE="$HOME/Pictures/Screenshots/screenshot-full-$(date +%Y-%m-%d_%H-%M-%S).png"

grim "$FILE" || exit 1

swappy -f "$FILE" -o "$FILE"

wl-copy < "$FILE"
notify-send "Full screenshot saved + copied" "$FILE"
