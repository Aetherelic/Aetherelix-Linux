#!/usr/bin/env bash

CLASS="aetherelic-welcome"

if hyprctl clients | grep -q "class: $CLASS"; then
  hyprctl dispatch closewindow "class:^($CLASS)$"
  exit 0
fi

hyprctl dispatch exec "[float; size 720 620; center; pin] bash $HOME/.config/hypr/scripts/aetherelic-welcome.sh"
