#!/usr/bin/env bash

kitty --class aetherelic-health-check --title "Aetherelic Rice Health" bash -lc '
clear
echo "=== Aetherelic rice health ==="
echo

echo "--- Hyprland errors ---"
hyprctl configerrors
echo

echo "--- Core processes ---"
for proc in quickshell swaync swayidle awww-daemon pipewire wireplumber; do
  printf "%-16s" "$proc"
  pgrep -a "$proc" || echo "not running"
done

echo
echo "--- Clipboard watchers ---"
pgrep -af "wl-paste.*cliphist store" || echo "cliphist watchers not running"

echo
echo "--- Current kernel ---"
uname -r

echo
echo "--- NVIDIA ---"
nvidia-smi --query-gpu=name,driver_version,temperature.gpu,pstate --format=csv 2>/dev/null || true

echo
echo "--- Monitor ---"
hyprctl monitors | grep -A5 "Monitor DP-2" || true

echo
echo "Press Enter to close."
read
'
