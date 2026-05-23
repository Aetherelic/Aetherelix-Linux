#!/usr/bin/env bash

CLASS="aetherelic-dropdown-terminal"

if hyprctl clients | grep -q "class: $CLASS"; then
  hyprctl dispatch closewindow "class:^($CLASS)$"
  exit 0
fi

hyprctl dispatch exec "[float; size 1200 620; center; pin] kitty \
  --class $CLASS \
  --title 'Aetherelic Drop Terminal' \
  --override background_opacity=0.58 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=12 \
  --override confirm_os_window_close=0"
