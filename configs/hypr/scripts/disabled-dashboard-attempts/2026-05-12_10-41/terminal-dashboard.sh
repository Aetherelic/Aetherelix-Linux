#!/usr/bin/env bash

LOG="/tmp/aetherelic-dashboard.log"
DASH_WS="name:aetherelic-dashboard"

{
  echo
  echo "=== dashboard launched at $(date) ==="

  if pgrep -f "kitty.*aetherelic-dash" >/dev/null 2>&1; then
    echo "Dashboard already open. Closing."
    pkill -f "kitty.*aetherelic-dash" 2>/dev/null || true
    hyprctl keyword general:layout dwindle >/dev/null 2>&1
    exit 0
  fi

  hyprctl dispatch workspace "$DASH_WS"
  sleep 0.3

  # Use master layout. On this system, the second opened window becomes the right-side master.
  hyprctl keyword general:layout master
  hyprctl keyword master:orientation right >/dev/null 2>&1 || true
  hyprctl keyword master:mfact 0.54 >/dev/null 2>&1 || true
  sleep 0.3

  echo "1/3 Opening Matrix first: left top stack..."
  hyprctl dispatch exec "kitty --class aetherelic-dash-matrix --title 'Aetherelic Matrix' --override background_opacity=0.46 --override dynamic_background_opacity=yes --override window_padding_width=8 $HOME/.config/hypr/scripts/matrix-rain.py"
  sleep 1.0

  echo "2/3 Opening terminal second: right-side master..."
  hyprctl dispatch exec "kitty --class aetherelic-dash-terminal --title 'Aetherelic Dashboard Terminal' --override background_opacity=0.50 --override dynamic_background_opacity=yes --override window_padding_width=10 $HOME/.config/hypr/scripts/dashboard-terminal.sh"
  sleep 1.0

  echo "3/3 Opening CAVA third: left bottom stack..."
  hyprctl dispatch exec "kitty --class aetherelic-dash-cava --title 'Aetherelic CAVA' --override background_opacity=0.46 --override dynamic_background_opacity=yes --override window_padding_width=8 $HOME/.config/hypr/scripts/dashboard-cava.sh"
  sleep 1.2

  # Focus terminal
  hyprctl dispatch focuswindow "class:^(aetherelic-dash-terminal)$" >/dev/null 2>&1 || true

  echo "Clients:"
  hyprctl clients | grep -E "class: aetherelic-dash|title: Aetherelic|workspace:" -A5 || true
  echo "Done."
} >> "$LOG" 2>&1
