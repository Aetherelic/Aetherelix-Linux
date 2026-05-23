#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/aetherelic-gaming-mode"
mkdir -p "$HOME/.cache"

gaming_on() {
  echo "on" > "$STATE_FILE"

  hyprctl keyword decoration:blur:enabled false
  hyprctl keyword decoration:active_opacity 1
  hyprctl keyword decoration:inactive_opacity 1
  hyprctl keyword animations:enabled false

  if command -v cpupower >/dev/null 2>&1; then
    sudo cpupower frequency-set -g performance >/dev/null 2>&1 || true
  fi

  notify-send "Gaming mode ON" "Blur/transparency/animations off. CPU set to performance."
}

gaming_off() {
  echo "off" > "$STATE_FILE"

  hyprctl reload

  # Restore glass mode explicitly
  hyprctl keyword decoration:blur:enabled true
  hyprctl keyword decoration:blur:size 12
  hyprctl keyword decoration:blur:passes 4
  hyprctl keyword decoration:blur:vibrancy 0.28
  hyprctl keyword decoration:active_opacity 0.84
  hyprctl keyword decoration:inactive_opacity 0.76
  hyprctl keyword decoration:fullscreen_opacity 1.0
  hyprctl keyword animations:enabled true

  if command -v cpupower >/dev/null 2>&1; then
    sudo cpupower frequency-set -g schedutil >/dev/null 2>&1 || sudo cpupower frequency-set -g ondemand >/dev/null 2>&1 || true
  fi

  notify-send "Gaming mode OFF" "Glassy blur/transparency restored."
}

if [ "$(cat "$STATE_FILE" 2>/dev/null)" = "on" ]; then
  gaming_off
else
  gaming_on
fi
