#!/usr/bin/env bash

STATE="$HOME/.cache/aetherelic-boot-theme-last"
VISION_DIR="$HOME/Pictures/visions"
WALL_SCRIPT="$HOME/.config/quickshell/components/wall/wall.sh"

mkdir -p "$HOME/.cache"

TODAY="$(date +%Y-%m-%d_%H)"
LAST="$(cat "$STATE" 2>/dev/null || true)"

# Only shuffle once per hour at most, so restarting Hyprland doesn't spam-change theme.
if [ "$LAST" = "$TODAY" ]; then
  exit 0
fi

echo "$TODAY" > "$STATE"

sleep 2

[ -d "$VISION_DIR" ] || exit 0
[ -x "$WALL_SCRIPT" ] || exit 0

WALL="$(
  find "$VISION_DIR" -maxdepth 1 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) |
  shuf -n 1
)"

[ -z "$WALL" ] && exit 0

bash "$WALL_SCRIPT" "$WALL" >/tmp/aetherelic-boot-theme.log 2>&1

notify-send "Boot theme shuffled" "$(basename "$WALL")"
