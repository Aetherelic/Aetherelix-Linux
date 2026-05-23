#!/usr/bin/env bash

VISION_DIR="$HOME/Pictures/visions"
WALL_SCRIPT="$HOME/.config/quickshell/components/wall/wall.sh"

if [ ! -d "$VISION_DIR" ]; then
  notify-send "Random theme" "No ~/Pictures/visions folder found"
  exit 1
fi

WALL="$(find "$VISION_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | shuf -n 1)"

if [ -z "$WALL" ]; then
  notify-send "Random theme" "No wallpapers found in ~/Pictures/visions"
  exit 1
fi

bash "$WALL_SCRIPT" "$WALL"

notify-send "Random theme applied" "$(basename "$WALL")"
