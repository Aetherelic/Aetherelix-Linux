#!/usr/bin/env bash

kitty --class aetherelic-info-popup --title "Aetherelic Now Playing" \
  --override background_opacity=0.64 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=16 \
  bash -lc '
clear
echo "╭────────────────────────────────────╮"
echo "│          Aetherelic Now Playing     │"
echo "╰────────────────────────────────────╯"
echo

if ! command -v playerctl >/dev/null 2>&1; then
  echo "playerctl is not installed."
else
  echo "--- Players ---"
  playerctl -l 2>/dev/null || echo "No active players."
  echo

  echo "--- Current ---"
  playerctl metadata --format "Player: {{playerName}}
Status: {{status}}
Artist: {{artist}}
Title:  {{title}}
Album:  {{album}}" 2>/dev/null || echo "Nothing playing."
fi

echo
echo "Press Enter to close."
read
'
