#!/usr/bin/env bash

notify-send "Aetherelic repair" "Refreshing rice components..."

# Regenerate adaptive configs if scripts exist
[ -x "$HOME/.config/hypr/scripts/generate-rofi-glass-theme.py" ] && "$HOME/.config/hypr/scripts/generate-rofi-glass-theme.py" >/dev/null 2>&1 || true
[ -x "$HOME/.config/hypr/scripts/generate-rofi-theme.py" ] && "$HOME/.config/hypr/scripts/generate-rofi-theme.py" >/dev/null 2>&1 || true
[ -x "$HOME/.config/hypr/scripts/generate-hypr-theme.py" ] && "$HOME/.config/hypr/scripts/generate-hypr-theme.py" >/dev/null 2>&1 || true

# Restart wallpaper daemon
pkill awww-daemon 2>/dev/null || true
awww-daemon >/tmp/awww-daemon.log 2>&1 & disown
sleep 1

# Reapply current wallpaper
if [ -e "$HOME/.config/hypr/current_wallpaper" ]; then
  awww img "$HOME/.config/hypr/current_wallpaper" --transition-type fade --transition-duration 1.2 --resize crop >/tmp/awww-wallpaper.log 2>&1 || true
fi

# Restart Quickshell
pkill quickshell 2>/dev/null || true
QML_XHR_ALLOW_FILE_READ=1 setsid quickshell --path "$HOME/.config/quickshell/shell.qml" >/tmp/quickshell.log 2>&1 & disown

# Restart notification daemon
pkill swaync 2>/dev/null || true
swaync >/tmp/swaync.log 2>&1 & disown

# Restart safe idle if present
if [ -x "$HOME/.config/hypr/scripts/safe-idle.sh" ]; then
  pkill swayidle 2>/dev/null || true
  bash "$HOME/.config/hypr/scripts/safe-idle.sh" >/tmp/safe-idle.log 2>&1 & disown
fi

# Restore audio defaults if scripts exist
[ -x "$HOME/.config/hypr/scripts/audio-game-output.sh" ] && "$HOME/.config/hypr/scripts/audio-game-output.sh" --quiet || true
[ -x "$HOME/.config/hypr/scripts/audio-fifine-input.sh" ] && "$HOME/.config/hypr/scripts/audio-fifine-input.sh" --quiet || true

# Reload Hyprland
hyprctl reload >/dev/null 2>&1 || true

sleep 1

ERRORS="$(hyprctl configerrors)"
if [ -z "$ERRORS" ]; then
  notify-send "Aetherelic repair complete" "Rice refreshed. Hyprland config clean."
else
  notify-send "Aetherelic repair warning" "Hyprland has config errors. Run rice health check."
fi
