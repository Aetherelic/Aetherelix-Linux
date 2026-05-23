#!/usr/bin/env bash

kitty --class aetherelic-notes --title "Aetherelic Notes" \
  --override background_opacity=0.66 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=16 \
  bash -lc '
clear
echo "╭────────────────────────────────────╮"
echo "│           Aetherelic Notes          │"
echo "╰────────────────────────────────────╯"
echo
cat "$HOME/Documents/Aetherelic/quick-notes.md"
echo
echo "Press Enter to close."
read
'
