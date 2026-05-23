#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"

choice="$(
cat <<'MENU' | rofi -dmenu -i -p "Rice Snapshots" -theme "$THEME"
󰆓  Create rice snapshot
󰁯  Restore rice snapshot
  Open snapshots folder
󰈙  Export latest snapshot
MENU
)"

case "$choice" in
  *"Create rice snapshot"*)
    bash "$HOME/.config/hypr/scripts/rice-create-snapshot.sh"
    ;;

  *"Restore rice snapshot"*)
    bash "$HOME/.config/hypr/scripts/rice-restore-snapshot.sh"
    ;;

  *"Open snapshots folder"*)
    dolphin "$HOME/Aetherelic-Rice-Snapshots"
    ;;

  *"Export latest snapshot"*)
    bash "$HOME/.config/hypr/scripts/rice-export-latest.sh"
    ;;
esac
