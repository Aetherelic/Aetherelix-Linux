#!/usr/bin/env bash

kitty --class aetherelic-info-popup --title "Aetherelic Network" \
  --override background_opacity=0.64 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=16 \
  bash -lc '
clear
echo "╭────────────────────────────────────╮"
echo "│          Aetherelic Network         │"
echo "╰────────────────────────────────────╯"
echo

echo "--- Devices ---"
nmcli device status 2>/dev/null || ip addr

echo
echo "--- Connections ---"
nmcli connection show --active 2>/dev/null || true

echo
echo "--- IP addresses ---"
ip -brief addr

echo
echo "Press Enter to close."
read
'
