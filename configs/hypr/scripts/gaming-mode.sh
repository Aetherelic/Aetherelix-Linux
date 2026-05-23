#!/usr/bin/env bash

case "$1" in
  on)
    sudo cpupower frequency-set -g performance
    notify-send "Gaming mode" "CPU governor set to performance"
    ;;
  off)
    sudo cpupower frequency-set -g schedutil 2>/dev/null || sudo cpupower frequency-set -g ondemand
    notify-send "Gaming mode" "CPU governor restored"
    ;;
  status)
    echo "=== CPU governors ==="
    cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor 2>/dev/null | sort -u
    echo
    echo "=== GameMode test ==="
    gamemoded -t 2>/dev/null || true
    ;;
  *)
    echo "Usage: gaming-mode.sh on|off|status"
    ;;
esac
