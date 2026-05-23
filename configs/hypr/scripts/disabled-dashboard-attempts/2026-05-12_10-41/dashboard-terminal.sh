#!/usr/bin/env bash

clear

if command -v fastfetch >/dev/null 2>&1; then
  fastfetch
else
  echo "AETHERELIC DASHBOARD"
  uname -a
fi

echo
echo "Right-side terminal."
echo "Matrix and CAVA are separate tiled Hyprland windows on the left."
echo

# Avoid your normal .bashrc fastfetch loop inside this dashboard terminal
exec bash --noprofile --norc
