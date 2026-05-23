#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/aetherelic-gaming-mode"

# Disable gaming mode only if enabled
if [ "$(cat "$STATE_FILE" 2>/dev/null)" = "on" ]; then
  bash "$HOME/.config/hypr/scripts/gaming-toggle.sh"
fi

hyprctl dispatch workspace 1
notify-send "Gaming profile" "Gaming mode disabled, returned to workspace 1"
