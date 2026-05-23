#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"
FILE="$HOME/Documents/Aetherelic/todo.txt"
touch "$FILE"

choice="$(
  cat "$FILE" | rofi -dmenu -i -p "Todo - select to toggle" -theme "$THEME"
)"

[ -z "$choice" ] && exit 0

tmp="$(mktemp)"

while IFS= read -r line; do
  if [ "$line" = "$choice" ]; then
    if [[ "$line" == "[ ] "* ]]; then
      echo "[x] ${line#"[ ] "}" >> "$tmp"
    elif [[ "$line" == "[x] "* ]]; then
      echo "[ ] ${line#"[x] "}" >> "$tmp"
    else
      echo "$line" >> "$tmp"
    fi
  else
    echo "$line" >> "$tmp"
  fi
done < "$FILE"

mv "$tmp" "$FILE"
notify-send "Todo updated" "$choice"
