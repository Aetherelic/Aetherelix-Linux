#!/usr/bin/env bash
set -euo pipefail

WALL_DIR="$HOME/.local/share/backgrounds/kaizen"
CURRENT="$HOME/.config/hypr/current_wallpaper"
LOG="/tmp/kaizen-swaybg.log"

mkdir -p "$WALL_DIR" "$HOME/.config/hypr"

CHOICE="$(
  find "$WALL_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
    | sort \
    | sed "s#^$WALL_DIR/##" \
    | rofi -dmenu -i -p "Wallpaper" -theme "$HOME/.config/rofi/kaizen-adaptive.rasi"
)"

[ -z "${CHOICE:-}" ] && exit 0

SELECTED="$WALL_DIR/$CHOICE"

rm -f "$CURRENT"
ln -s "$SELECTED" "$CURRENT"

if [ -x "$HOME/.config/hypr/scripts/kaizen-generate-theme.sh" ]; then
  bash "$HOME/.config/hypr/scripts/kaizen-generate-theme.sh" "$SELECTED"
fi

pkill swaybg 2>/dev/null || true
sleep 0.2
swaybg -i "$SELECTED" -m fill >"$LOG" 2>&1 & disown

pkill waybar 2>/dev/null || true
waybar >/tmp/kaizen-waybar.log 2>&1 & disown

notify-send "Kaizen Wallpaper" "Applied: $CHOICE" 2>/dev/null || true
