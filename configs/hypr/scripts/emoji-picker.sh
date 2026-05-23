#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"

choice="$(
cat <<'MENU' | rofi -dmenu -i -p "Emoji" -theme "$THEME"
🔥 fire
✨ sparkle
💀 skull
😭 crying
💜 purple heart
🖤 black heart
✅ check
❌ cross
⚠️ warning
👑 crown
🎧 headphones
🎮 gaming
🖥️ desktop
⌨️ keyboard
🐧 linux
 arch
 hyprland
󰆍 terminal
󰈹 firefox
󰓃 audio
󰂯 bluetooth
󰹑 screenshot
󰐥 power
MENU
)"

[ -z "$choice" ] && exit 0

emoji="$(printf "%s" "$choice" | awk '{print $1}')"
printf "%s" "$emoji" | wl-copy
notify-send "Emoji copied" "$emoji"
