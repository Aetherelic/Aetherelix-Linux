#!/usr/bin/env bash

kitty --class aetherelic-info-popup --title "Aetherelic Storage" \
  --override background_opacity=0.64 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=16 \
  bash -lc '
clear
echo "╭────────────────────────────────────╮"
echo "│          Aetherelic Storage         │"
echo "╰────────────────────────────────────╯"
echo

echo "--- Filesystems ---"
df -h -x tmpfs -x devtmpfs

echo
echo "--- Block devices ---"
lsblk -f

echo
echo "Press Enter to close."
read
'
