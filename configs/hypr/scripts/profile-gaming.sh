#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/aetherelic-gaming-mode"
mkdir -p "$HOME/.cache"

# Switch to dedicated gaming workspace
hyprctl dispatch workspace 8

# Enable gaming mode only if not already enabled
if [ "$(cat "$STATE_FILE" 2>/dev/null)" != "on" ]; then
  bash "$HOME/.config/hypr/scripts/gaming-toggle.sh"
fi

# Start Steam if not running
if ! pgrep -x steam >/dev/null 2>&1; then
  steam >/tmp/steam-aetherelic.log 2>&1 & disown
fi

notify-send "Gaming profile" "Workspace 8 + gaming mode enabled"
