#!/usr/bin/env bash
set -euo pipefail

WALL_DIR="$HOME/.local/share/backgrounds/kaizen"
CURRENT="$HOME/.config/hypr/current_wallpaper"

mkdir -p "$WALL_DIR" "$HOME/.config/hypr"

CHOICE="$(
  find "$WALL_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
    | sort \
    | sed "s#^$WALL_DIR/##" \
    | rofi -dmenu -i -p "Wallpaper"
)"

[ -z "${CHOICE:-}" ] && exit 0

SELECTED="$WALL_DIR/$CHOICE"

cp "$SELECTED" "$CURRENT"

pkill swaybg 2>/dev/null || true
swaybg -i "$CURRENT" -m fill >/tmp/kaizen-swaybg.log 2>&1 & disown

notify-send "Kaizen Wallpaper" "Applied: $CHOICE" 2>/dev/null || true
