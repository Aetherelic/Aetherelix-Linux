#!/usr/bin/env bash

CLASS="aetherelic-btop-monitor"

if hyprctl clients | grep -q "class: $CLASS"; then
  hyprctl dispatch closewindow "class:^($CLASS)$"
  exit 0
fi

hyprctl dispatch exec "[float; size 1250 720; center; pin] kitty \
  --class $CLASS \
  --title 'Aetherelic System Monitor' \
  --override background_opacity=0.62 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=10 \
  --override confirm_os_window_close=0 \
  btop"
