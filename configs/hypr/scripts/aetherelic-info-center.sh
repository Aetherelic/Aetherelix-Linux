#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"

choice="$(
cat <<'MENU' | rofi -dmenu -i -p "Info Center" -theme "$THEME"
󰃭  Calendar
󰖐  Weather
󰝚  Now playing
󰖩  Network
󰋊  Storage
󰌢  System summary
MENU
)"

case "$choice" in
  *"Calendar"*) bash "$HOME/.config/hypr/scripts/popup-calendar.sh" ;;
  *"Weather"*) bash "$HOME/.config/hypr/scripts/popup-weather.sh" ;;
  *"Now playing"*) bash "$HOME/.config/hypr/scripts/popup-nowplaying.sh" ;;
  *"Network"*) bash "$HOME/.config/hypr/scripts/popup-network.sh" ;;
  *"Storage"*) bash "$HOME/.config/hypr/scripts/popup-storage.sh" ;;
  *"System summary"*) bash "$HOME/.config/hypr/scripts/popup-system.sh" ;;
esac
