#!/usr/bin/env bash

choice="$(
  cat <<'MENU' | rofi -dmenu -i -p "Kaizen Tools" -theme "$HOME/.config/rofi/kaizen-adaptive.rasi"
Welcome to Kaizen
Update Kaizen
Wallpaper Picker
Show Keybinds
Keybind Help
Install Gaming Profile
Install Productivity Profile
Open File Manager
Open System Monitor
Open Disk Utility
Audio Settings
Bluetooth Settings
Network Settings
About Kaizen
MENU
)"

case "$choice" in
  "Welcome to Kaizen")
    kaizen-welcome
    ;;

  "Update Kaizen")
    kitty -e bash -lc 'kaizen-update; echo; read -rp "Press Enter to close..."'
    ;;

  "Wallpaper Picker")
    bash "$HOME/.config/hypr/scripts/kaizen-wallpaper-picker.sh"
    ;;

  "Show Keybinds"|"Keybind Help")
    kitty -e bash -lc 'bash "$HOME/.config/hypr/scripts/kaizen-keybinds.sh"; echo; read -rp "Press Enter to close..."'
    ;;

  "Install Gaming Profile")
    kitty -e bash -lc 'kaizen-install-profile gaming; echo; read -rp "Press Enter to close..."'
    ;;

  "Install Productivity Profile")
    kitty -e bash -lc 'kaizen-install-profile productivity; echo; read -rp "Press Enter to close..."'
    ;;

  "Open File Manager")
    nautilus >/dev/null 2>&1 &
    ;;

  "Open System Monitor")
    gnome-system-monitor >/dev/null 2>&1 &
    ;;

  "Open Disk Utility")
    gnome-disks >/dev/null 2>&1 &
    ;;

  "Audio Settings")
    pavucontrol >/dev/null 2>&1 &
    ;;

  "Bluetooth Settings")
    blueman-manager >/dev/null 2>&1 &
    ;;

  "Network Settings")
    kitty -e nmtui
    ;;

  "About Kaizen")
    kitty -e bash -lc 'cat /etc/os-release; echo; echo "Repo: https://github.com/Aetherelic/Kaizen-Linux"; echo; read -rp "Press Enter to close..."'
    ;;
esac
