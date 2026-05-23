#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"
[ -x "$HOME/.config/hypr/scripts/generate-rofi-glass-theme.py" ] && "$HOME/.config/hypr/scripts/generate-rofi-glass-theme.py" >/dev/null 2>&1

choice="$(
cat <<'MENU' | rofi -dmenu -i -p "Power" -theme "$THEME"
󰍃  Logout Hyprland
󰒲  Suspend
󰜉  Reboot
󰐥  Shutdown
󰜺  Cancel
MENU
)"

confirm_action() {
  local action="$1"
  local yes="Yes, $action"
  local picked
  picked="$(
cat <<MENU | rofi -dmenu -i -p "$action?" -theme "$THEME"
$yes
Cancel
MENU
)"
  [ "$picked" = "$yes" ]
}

case "$choice" in
  *"Logout Hyprland"*)
    if confirm_action "logout"; then
      hyprctl dispatch exit
    fi
    ;;

  *"Suspend"*)
    if confirm_action "suspend"; then
      systemctl suspend
    fi
    ;;

  *"Reboot"*)
    if confirm_action "reboot"; then
      systemctl reboot
    fi
    ;;

  *"Shutdown"*)
    if confirm_action "shutdown"; then
      systemctl poweroff
    fi
    ;;
esac
