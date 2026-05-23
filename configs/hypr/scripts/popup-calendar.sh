#!/usr/bin/env bash

kitty --class aetherelic-info-popup --title "Aetherelic Calendar" \
  --override background_opacity=0.64 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=16 \
  bash -lc '
clear
echo "╭────────────────────────────────────╮"
echo "│          Aetherelic Calendar        │"
echo "╰────────────────────────────────────╯"
echo
date +"%A, %d %B %Y"
echo
cal -3
echo
echo "Press Enter to close."
read
'
