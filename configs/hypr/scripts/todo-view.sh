#!/usr/bin/env bash

kitty --class aetherelic-todo --title "Aetherelic Todo" \
  --override background_opacity=0.66 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=16 \
  bash -lc '
clear
echo "╭────────────────────────────────────╮"
echo "│            Aetherelic Todo          │"
echo "╰────────────────────────────────────╯"
echo
cat "$HOME/Documents/Aetherelic/todo.txt"
echo
echo "Press Enter to close."
read
'
