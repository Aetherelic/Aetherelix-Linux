#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"

choice="$(
cat <<'MENU' | rofi -dmenu -i -p "Notes / Todo" -theme "$THEME"
󰎞  Add quick note
󰎞  View notes
󰄬  Add todo
󰄬  Toggle todo
󰄬  View todo
  Open notes folder
󰔛  Focus timer
MENU
)"

case "$choice" in
  *"Add quick note"*) bash "$HOME/.config/hypr/scripts/quick-note.sh" ;;
  *"View notes"*) bash "$HOME/.config/hypr/scripts/notes-view.sh" ;;
  *"Add todo"*) bash "$HOME/.config/hypr/scripts/todo-add.sh" ;;
  *"Toggle todo"*) bash "$HOME/.config/hypr/scripts/todo-menu.sh" ;;
  *"View todo"*) bash "$HOME/.config/hypr/scripts/todo-view.sh" ;;
  *"Open notes folder"*) dolphin "$HOME/Documents/Aetherelic" ;;
  *"Focus timer"*) bash "$HOME/.config/hypr/scripts/focus-timer.sh" ;;
esac
