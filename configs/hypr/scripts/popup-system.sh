#!/usr/bin/env bash

kitty --class aetherelic-info-popup --title "Aetherelic System" \
  --override background_opacity=0.64 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=16 \
  bash -lc '
clear
echo "╭────────────────────────────────────╮"
echo "│          Aetherelic System          │"
echo "╰────────────────────────────────────╯"
echo

echo "--- Kernel ---"
uname -r

echo
echo "--- Uptime ---"
uptime -p

echo
echo "--- CPU governor ---"
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor 2>/dev/null | sort -u || echo "No governor info."

echo
echo "--- GPU ---"
nvidia-smi --query-gpu=name,driver_version,temperature.gpu,pstate,utilization.gpu,memory.used,memory.total --format=csv 2>/dev/null || echo "No NVIDIA info."

echo
echo "--- Memory ---"
free -h

echo
echo "Press Enter to close."
read
'
