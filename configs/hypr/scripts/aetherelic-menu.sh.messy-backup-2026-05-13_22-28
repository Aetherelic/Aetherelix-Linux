#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"

# Regenerate adaptive rofi theme if available
[ -x "$HOME/.config/hypr/scripts/generate-rofi-theme.py" ] && "$HOME/.config/hypr/scripts/generate-rofi-theme.py" >/dev/null 2>&1

choice="$(
cat <<'MENU' | rofi -dmenu -i -p "Aetherelic Menu" -theme "$THEME"
󰣇  Alt+Space      App launcher
󰸉  Super+Shift+A  Wallpaper / adaptive theme picker
󰸉  Super+Ctrl+A   Random adaptive theme
󰎆  Super+M        Small music panel
󰆍  Super+Enter    Terminal
  Super+`        Drop-down glass terminal
  Super+Shift+`  System monitor
  Super+E        File manager
󰈹  Super+F        Firefox
  Vesktop / Discord with screenshare
  Super+Ctrl+P  Colour picker
󰞅  Super+.       Emoji picker
  Record area
  Record full screen
󰙧  Stop recording
  Open recordings folder
󰚰  Check updates
󰌨  Rice health check
󰑓  Super+Shift+R  Repair / refresh rice
󰚰  Super+Shift+M  Maintenance menu
󰋼  Super+I        Info Center
󰇄  Super+W        Welcome / session popup
󰆓  Super+Shift+B  Rice snapshot/restore
󰎞  Super+K        Notes / Todo
󰔛  Super+Shift+K  Focus timer
󰌾  Super+C        Clipboard history
󰆴  Super+Shift+C  Clear clipboard
  Super+L        Lock screen
⏻  Super+Shift+L  Power menu
󰂚  Super+N        Notification centre
󰂛  Super+Shift+N  Do Not Disturb toggle
󰹑  Print          Area screenshot
󰹑  Super+Print    Full screenshot
  Open screenshots folder
󰕾  Super+Ctrl+↑   Volume up
󰖀  Super+Ctrl+↓   Volume down
󰖁  Super+Ctrl+M   Mute volume
󰐊  Super+Ctrl+Space Play / pause media
󰒭  Super+Ctrl+→   Next track
󰒮  Super+Ctrl+←   Previous track
󰂯  Bluetooth manager
󰓃  Set output to Astro A50 Game
󰍬  Set input to Fifine Microphone
  Super+G        Gaming profile
  Super+Shift+G  Leave gaming profile
  Super+O        Recording profile
󰝚  Super+Y        Media profile
  Super+F12     Toggle gaming mode
󰹹  Super+Shift+R  Restart Quickshell
󰍹  Super+V        Toggle floating
󰁌  Super+Shift+V  Centre floating window
󰘶  Super+Q        Close active window
󰁯  Super+Shift+Arrows Move tiled window
󰁯  Super+Alt+Arrows   Nudge floating window
  Reload Hyprland
󰜉  Reboot system
󰐥  Shutdown system
MENU
)"

case "$choice" in
  *"App launcher"*)
    QML_XHR_ALLOW_FILE_READ=1 quickshell --path "$HOME/.config/quickshell/components/Launcher/Sway.qml"
    ;;

  *"Wallpaper"*)
    bash "$HOME/.config/quickshell/components/wall/wall.sh"
    ;;

  *"Random adaptive theme"*)
    bash "$HOME/.config/hypr/scripts/random-theme.sh"
    ;;

  *"Small music"*)
    hyprctl dispatch global quickshell:musicToggle
    ;;

  *"Drop-down glass terminal"*)
    bash "$HOME/.config/hypr/scripts/dropdown-terminal.sh"
    ;;

  *"System monitor"*)
    bash "$HOME/.config/hypr/scripts/dropdown-btop.sh"
    ;;

  *"Terminal"*)
    kitty
    ;;

  *"File manager"*)
    dolphin
    ;;

  *"Firefox"*)
    firefox
    ;;

  *"Vesktop / Discord"*)
    flatpak run dev.vencord.Vesktop
    ;;

  *"Colour picker"*)
    bash "$HOME/.config/hypr/scripts/color-picker.sh"
    ;;

  *"Emoji picker"*)
    bash "$HOME/.config/hypr/scripts/emoji-picker.sh"
    ;;

  *"Record area"*)
    bash "$HOME/.config/hypr/scripts/record-area.sh"
    ;;

  *"Record full screen"*)
    bash "$HOME/.config/hypr/scripts/record-full.sh"
    ;;

  *"Stop recording"*)
    bash "$HOME/.config/hypr/scripts/record-stop.sh"
    ;;

  *"Open recordings folder"*)
    dolphin "$HOME/Videos/Recordings"
    ;;

  *"Check updates"*)
    bash "$HOME/.config/hypr/scripts/update-check.sh"
    ;;

  *"Notes / Todo"*)
    bash "$HOME/.config/hypr/scripts/aetherelic-notes-menu.sh"
    ;;

  *"Focus timer"*)
    bash "$HOME/.config/hypr/scripts/focus-timer.sh"
    ;;

  *"Rice snapshot/restore"*)
    bash "$HOME/.config/hypr/scripts/rice-snapshot-menu.sh"
    ;;

  *"Welcome / session popup"*)
    bash "$HOME/.config/hypr/scripts/aetherelic-welcome.sh"
    ;;

  *"Info Center"*)
    bash "$HOME/.config/hypr/scripts/aetherelic-info-center.sh"
    ;;

  *"Maintenance menu"*)
    bash "$HOME/.config/hypr/scripts/aetherelic-maintenance-menu.sh"
    ;;

  *"Repair / refresh rice"*)
    bash "$HOME/.config/hypr/scripts/repair-rice.sh"
    ;;

  *"Rice health check"*)
    bash "$HOME/.config/hypr/scripts/rice-health.sh"
    ;;

  *"Clipboard history"*)
    bash "$HOME/.config/hypr/scripts/clipboard-picker.sh"
    ;;

  *"Clear clipboard"*)
    bash "$HOME/.config/hypr/scripts/clipboard-clear.sh"
    ;;

  *"Lock screen"*)
    hyprlock
    ;;

  *"Power menu"*)
    bash "$HOME/.config/hypr/scripts/power-menu.sh"
    ;;

  *"Notification centre"*)
    swaync-client -t -sw
    ;;

  *"Do Not Disturb"*)
    swaync-client -d
    ;;

  *"Area screenshot"*)
    mkdir -p "$HOME/Pictures/Screenshots"
    FILE="$HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
    grim -g "$(slurp)" "$FILE" && wl-copy < "$FILE" && notify-send "Screenshot copied" "$FILE"
    ;;

  *"Full screenshot"*)
    mkdir -p "$HOME/Pictures/Screenshots"
    FILE="$HOME/Pictures/Screenshots/screenshot-full-$(date +%Y-%m-%d_%H-%M-%S).png"
    grim "$FILE" && wl-copy < "$FILE" && notify-send "Full screenshot copied" "$FILE"
    ;;

  *"Open screenshots folder"*)
    dolphin "$HOME/Pictures/Screenshots"
    ;;

  *"Volume up"*)
    "$HOME/.config/hypr/scripts/volume.sh" up
    ;;

  *"Volume down"*)
    "$HOME/.config/hypr/scripts/volume.sh" down
    ;;

  *"Mute volume"*)
    "$HOME/.config/hypr/scripts/volume.sh" mute
    ;;

  *"Play / pause"*)
    "$HOME/.config/hypr/scripts/media.sh" play-pause
    ;;

  *"Next track"*)
    "$HOME/.config/hypr/scripts/media.sh" next
    ;;

  *"Previous track"*)
    "$HOME/.config/hypr/scripts/media.sh" previous
    ;;

  *"Bluetooth manager"*)
    blueman-manager
    ;;

  *"Set output to Astro A50 Game"*)
    bash "$HOME/.config/hypr/scripts/audio-game-output.sh"
    ;;

  *"Set input to Fifine Microphone"*)
    bash "$HOME/.config/hypr/scripts/audio-fifine-input.sh"
    ;;

  *"Gaming profile"*)
    bash "$HOME/.config/hypr/scripts/profile-gaming.sh"
    ;;

  *"Leave gaming profile"*)
    bash "$HOME/.config/hypr/scripts/profile-gaming-off.sh"
    ;;

  *"Recording profile"*)
    bash "$HOME/.config/hypr/scripts/profile-recording.sh"
    ;;

  *"Media profile"*)
    bash "$HOME/.config/hypr/scripts/profile-media.sh"
    ;;

  *"Toggle gaming mode"*)
    bash "$HOME/.config/hypr/scripts/gaming-toggle.sh"
    ;;

  *"Restart Quickshell"*)
    pkill quickshell 2>/dev/null || true
    QML_XHR_ALLOW_FILE_READ=1 quickshell --path "$HOME/.config/quickshell/shell.qml" &
    ;;

  *"Toggle floating"*)
    hyprctl dispatch togglefloating
    ;;

  *"Centre floating"*)
    hyprctl dispatch centerwindow
    ;;

  *"Close active"*)
    hyprctl dispatch killactive
    ;;

  *"Reload Hyprland"*)
    hyprctl reload
    notify-send "Hyprland" "Reloaded config"
    ;;

  *"Reboot system"*)
    systemctl reboot
    ;;

  *"Shutdown system"*)
    systemctl poweroff
    ;;
esac
