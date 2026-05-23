#!/usr/bin/env bash

kitty --class aetherelic-update-check --title "Aetherelic Update Check" bash -lc '
clear
echo "=== Aetherelic update check ==="
echo

echo "--- Official repo updates ---"
checkupdates 2>/dev/null || echo "No official repo updates or pacman-contrib unavailable."

echo
echo "--- AUR updates ---"
yay -Qua 2>/dev/null || echo "No AUR updates or yay unavailable."

echo
echo "Press Enter to close."
read
'
