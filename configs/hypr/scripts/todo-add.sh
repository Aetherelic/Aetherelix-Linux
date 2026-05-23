#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"
FILE="$HOME/Documents/Aetherelic/todo.txt"

todo="$(rofi -dmenu -p "Add todo" -theme "$THEME")"
[ -z "$todo" ] && exit 0

echo "[ ] $todo" >> "$FILE"
notify-send "Todo added" "$todo"
