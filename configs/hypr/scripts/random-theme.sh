#!/usr/bin/env bash
set -euo pipefail

WALL_DIR="$HOME/.local/share/backgrounds/kaizen"
CURRENT="$HOME/.config/hypr/current_wallpaper"

mkdir -p "$HOME/.config/hypr"

WALL="$(
  find "$WALL_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) 2>/dev/null \
    | shuf -n 1
)"

if [ -z "${WALL:-}" ]; then
  notify-send "Random theme" "No Kaizen wallpapers found in $WALL_DIR" 2>/dev/null || true
  exit 1
fi

cp "$WALL" "$CURRENT"

pkill swaybg 2>/dev/null || true
swaybg -i "$CURRENT" -m fill >/tmp/kaizen-swaybg.log 2>&1 & disown

notify-send "Random theme" "Applied: $(basename "$WALL")" 2>/dev/null || true
