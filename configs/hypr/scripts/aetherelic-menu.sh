#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"
[ -f "$THEME" ] || THEME="$HOME/.config/rofi/aetherelic-adaptive.rasi"

run_menu() {
  local prompt="$1"
  rofi -dmenu -i -p "$prompt" -theme "$THEME"
}

main_menu() {
cat <<'MENU' | run_menu "Aetherelic"
󰀻  Apps
󰸉  Rice / Theme
󰌢  System
󰓃  Audio / Media
󰹑  Screenshots / Recording
  Gaming
󰎞  Notes / Info
󰚰  Maintenance / Backup
󰐥  Power
MENU
}

apps_menu() {
cat <<'MENU' | run_menu "Apps"
󰆍  Terminal
  Drop-down terminal
  System monitor
  File manager
󰈹  Firefox
  Vesktop / Discord
󰂯  Bluetooth manager
󰌾  Clipboard history
󰆴  Clear clipboard
MENU
}

rice_menu() {
cat <<'MENU' | run_menu "Rice / Theme"
󰸉  Wallpaper picker
󰸉  Random adaptive theme
󰑓  Repair / refresh rice
󰇄  Welcome popup
  Colour picker
󰞅  Emoji picker
󰘳  Export keybind cheat sheet
󰊢  Export GitHub dotfiles
MENU
}

system_menu() {
cat <<'MENU' | run_menu "System"
󰋼  Info Center
󰌨  Rice health check
󰅶  Toggle caffeine
󰍹  Turn screens off
󰍹  Toggle floating
󰁌  Centre floating window
󰘶  Close active window
  Reload Hyprland
MENU
}

audio_menu() {
cat <<'MENU' | run_menu "Audio / Media"
󰓃  Set output to Astro A50 Game
󰍬  Set input to Fifine Microphone
󰕾  Volume up
󰖀  Volume down
󰖁  Mute volume
󰐊  Play / pause
󰒭  Next track
󰒮  Previous track
󰝚  Small music panel
󰝚  Media profile
MENU
}

capture_menu() {
cat <<'MENU' | run_menu "Screenshots / Recording"
󰹑  Area screenshot
󰹑  Full screenshot
  Open screenshots folder
  Record area
  Record full screen
󰙧  Stop recording
  Open recordings folder
  Recording profile
MENU
}

gaming_menu() {
cat <<'MENU' | run_menu "Gaming"
  Gaming profile
  Leave gaming profile
  Toggle gaming mode
󰍹  Fullscreen active window
󰁯  Move window with arrows
󰁯  Nudge floating window
MENU
}

notes_menu() {
cat <<'MENU' | run_menu "Notes / Info"
󰎞  Notes / Todo
󰔛  Focus timer
󰋼  Info Center
󰃭  Calendar
󰖐  Weather
󰝚  Now playing
󰖩  Network
󰋊  Storage
󰌢  System summary
MENU
}

maintenance_menu() {
cat <<'MENU' | run_menu "Maintenance / Backup"
󰚰  Maintenance menu
󰆓  Rice snapshot / restore
󰑓  Repair / refresh rice
󰚰  Check updates
󰘳  Export keybind cheat sheet
󰊢  Export GitHub dotfiles
  Open snapshots folder
MENU
}

power_menu() {
cat <<'MENU' | run_menu "Power"
󰐥  Power menu
󰜉  Reboot
󰐥  Shutdown
󰍃  Logout Hyprland
󰜺  Cancel
MENU
}

choice="$(main_menu)"

case "$choice" in
  *"Apps"*) sub="$(apps_menu)" ;;
  *"Rice / Theme"*) sub="$(rice_menu)" ;;
  *"System"*) sub="$(system_menu)" ;;
  *"Audio / Media"*) sub="$(audio_menu)" ;;
  *"Screenshots / Recording"*) sub="$(capture_menu)" ;;
  *"Gaming"*) sub="$(gaming_menu)" ;;
  *"Notes / Info"*) sub="$(notes_menu)" ;;
  *"Maintenance / Backup"*) sub="$(maintenance_menu)" ;;
  *"Power"*) sub="$(power_menu)" ;;
  *) exit 0 ;;
esac

case "$sub" in
  # Apps
  *"Terminal"*) kitty ;;
  *"Drop-down terminal"*) bash "$HOME/.config/hypr/scripts/dropdown-terminal.sh" ;;
  *"System monitor"*) bash "$HOME/.config/hypr/scripts/dropdown-btop.sh" ;;
  *"File manager"*) dolphin ;;
  *"Firefox"*) firefox ;;
  *"Vesktop / Discord"*) flatpak run dev.vencord.Vesktop ;;
  *"Bluetooth manager"*) blueman-manager ;;
  *"Clipboard history"*) bash "$HOME/.config/hypr/scripts/clipboard-picker.sh" ;;
  *"Clear clipboard"*) bash "$HOME/.config/hypr/scripts/clipboard-clear.sh" ;;

  # Rice / Theme
  *"Wallpaper picker"*) bash "$HOME/.config/quickshell/components/wall/wall.sh" ;;
  *"Random adaptive theme"*) bash "$HOME/.config/hypr/scripts/random-theme.sh" ;;
  *"Repair / refresh rice"*) bash "$HOME/.config/hypr/scripts/repair-rice.sh" ;;
  *"Welcome popup"*) bash "$HOME/.config/hypr/scripts/aetherelic-welcome-launch.sh" ;;
  *"Colour picker"*) bash "$HOME/.config/hypr/scripts/color-picker.sh" ;;
  *"Emoji picker"*) bash "$HOME/.config/hypr/scripts/emoji-picker.sh" ;;
  *"Export keybind cheat sheet"*) bash "$HOME/.config/hypr/scripts/export-keybind-cheatsheet.sh" ;;
  *"Export GitHub dotfiles"*) bash "$HOME/.config/hypr/scripts/export-dotfiles-github.sh" ;;

  # System
  *"Info Center"*) bash "$HOME/.config/hypr/scripts/aetherelic-info-center.sh" ;;
  *"Rice health check"*) bash "$HOME/.config/hypr/scripts/rice-health.sh" ;;
  *"Toggle caffeine"*) bash "$HOME/.config/hypr/scripts/caffeine-toggle.sh" ;;
  *"Turn screens off"*) bash "$HOME/.config/hypr/scripts/screen-off.sh" ;;
  *"Toggle floating"*) hyprctl dispatch togglefloating ;;
  *"Centre floating"*) hyprctl dispatch centerwindow ;;
  *"Close active"*) hyprctl dispatch killactive ;;
  *"Reload Hyprland"*) hyprctl reload && notify-send "Hyprland" "Reloaded" ;;

  # Audio / Media
  *"Set output to Astro A50 Game"*) bash "$HOME/.config/hypr/scripts/audio-game-output.sh" ;;
  *"Set input to Fifine Microphone"*) bash "$HOME/.config/hypr/scripts/audio-fifine-input.sh" ;;
  *"Volume up"*) "$HOME/.config/hypr/scripts/volume.sh" up ;;
  *"Volume down"*) "$HOME/.config/hypr/scripts/volume.sh" down ;;
  *"Mute volume"*) "$HOME/.config/hypr/scripts/volume.sh" mute ;;
  *"Play / pause"*) "$HOME/.config/hypr/scripts/media.sh" play-pause ;;
  *"Next track"*) "$HOME/.config/hypr/scripts/media.sh" next ;;
  *"Previous track"*) "$HOME/.config/hypr/scripts/media.sh" previous ;;
  *"Small music panel"*) hyprctl dispatch global quickshell:musicToggle ;;
  *"Media profile"*) bash "$HOME/.config/hypr/scripts/profile-media.sh" ;;

  # Screenshots / Recording
  *"Area screenshot"*) bash "$HOME/.config/hypr/scripts/screenshot-area.sh" ;;
  *"Full screenshot"*) bash "$HOME/.config/hypr/scripts/screenshot-full.sh" ;;
  *"Open screenshots folder"*) dolphin "$HOME/Pictures/Screenshots" ;;
  *"Record area"*) bash "$HOME/.config/hypr/scripts/record-area.sh" ;;
  *"Record full screen"*) bash "$HOME/.config/hypr/scripts/record-full.sh" ;;
  *"Stop recording"*) bash "$HOME/.config/hypr/scripts/record-stop.sh" ;;
  *"Open recordings folder"*) dolphin "$HOME/Videos/Recordings" ;;
  *"Recording profile"*) bash "$HOME/.config/hypr/scripts/profile-recording.sh" ;;

  # Gaming
  *"Gaming profile"*) bash "$HOME/.config/hypr/scripts/profile-gaming.sh" ;;
  *"Leave gaming profile"*) bash "$HOME/.config/hypr/scripts/profile-gaming-off.sh" ;;
  *"Toggle gaming mode"*) bash "$HOME/.config/hypr/scripts/gaming-toggle.sh" ;;
  *"Fullscreen active window"*) hyprctl dispatch fullscreen 0 ;;
  *"Move window with arrows"*) notify-send "Move window" "Use SUPER+SHIFT+Arrow keys" ;;
  *"Nudge floating window"*) notify-send "Nudge window" "Use SUPER+ALT+Arrow keys" ;;

  # Notes / Info
  *"Notes / Todo"*) bash "$HOME/.config/hypr/scripts/aetherelic-notes-menu.sh" ;;
  *"Focus timer"*) bash "$HOME/.config/hypr/scripts/focus-timer.sh" ;;
  *"Calendar"*) bash "$HOME/.config/hypr/scripts/popup-calendar.sh" ;;
  *"Weather"*) bash "$HOME/.config/hypr/scripts/popup-weather.sh" ;;
  *"Now playing"*) bash "$HOME/.config/hypr/scripts/popup-nowplaying.sh" ;;
  *"Network"*) bash "$HOME/.config/hypr/scripts/popup-network.sh" ;;
  *"Storage"*) bash "$HOME/.config/hypr/scripts/popup-storage.sh" ;;
  *"System summary"*) bash "$HOME/.config/hypr/scripts/popup-system.sh" ;;

  # Maintenance / Backup
  *"Maintenance menu"*) bash "$HOME/.config/hypr/scripts/aetherelic-maintenance-menu.sh" ;;
  *"Rice snapshot / restore"*) bash "$HOME/.config/hypr/scripts/rice-snapshot-menu.sh" ;;
  *"Check updates"*) bash "$HOME/.config/hypr/scripts/update-check.sh" ;;
  *"Open snapshots folder"*) dolphin "$HOME/Aetherelic-Rice-Snapshots" ;;

  # Power
  *"Power menu"*) bash "$HOME/.config/hypr/scripts/power-menu.sh" ;;
  *"Reboot"*) systemctl reboot ;;
  *"Shutdown"*) systemctl poweroff ;;
  *"Logout Hyprland"*) hyprctl dispatch exit ;;
esac
