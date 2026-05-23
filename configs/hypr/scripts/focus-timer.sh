#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"

choice="$(
cat <<'MENU' | rofi -dmenu -i -p "Focus Timer" -theme "$THEME"
15 minutes
25 minutes
45 minutes
60 minutes
MENU
)"

case "$choice" in
  "15 minutes") mins=15 ;;
  "25 minutes") mins=25 ;;
  "45 minutes") mins=45 ;;
  "60 minutes") mins=60 ;;
  *) exit 0 ;;
esac

notify-send "Focus started" "$mins minutes"

(
  sleep "$((mins * 60))"
  notify-send "Focus complete" "$mins minutes finished"
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null || true
) & disown
