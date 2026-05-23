#!/usr/bin/env bash

kitty --class aetherelic-welcome --title "Aetherelic Welcome" \
  --override background_opacity=0.78 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=20 \
  --override confirm_os_window_close=0 \
  --override font_size=11 \
  bash -lc '
clear

WALL="$(readlink -f "$HOME/.config/hypr/current_wallpaper" 2>/dev/null || echo "unknown")"
WALL_NAME="$(basename "$WALL" 2>/dev/null)"
if [ ${#WALL_NAME} -gt 28 ]; then
  WALL_NAME="${WALL_NAME:0:25}..."
fi

GPU="$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | head -1 | sed "s/NVIDIA GeForce //")"
DRIVER="$(nvidia-smi --query-gpu=driver_version --format=csv,noheader 2>/dev/null | head -1)"
TEMP="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)"
MODE="$(hyprctl monitors 2>/dev/null | awk "/Monitor DP-2/{getline; print \$1; exit}")"
KERNEL="$(uname -r)"
UPTIME="$(uptime -p | sed "s/up //")"

printf "\n"
printf "  AETHERELIC SESSION\n"
printf "  ─────────────────────────────────────\n\n"

printf "  %-11s %s\n" "user" "$USER"
printf "  %-11s %s\n" "kernel" "$KERNEL"
printf "  %-11s %s\n" "uptime" "$UPTIME"
printf "  %-11s %s\n" "monitor" "${MODE:-unknown}"
printf "  %-11s %s\n" "gpu" "${GPU:-unavailable}"
printf "  %-11s %s / %s°C\n" "nvidia" "${DRIVER:-unknown}" "${TEMP:-?}"
printf "  %-11s %s\n" "wallpaper" "$WALL_NAME"

printf "\n"
printf "  STATUS\n"
printf "  ─────────────────────────────────────\n"
printf "  %-11s %s\n" "hyprland" "$(test -z "$(hyprctl configerrors)" && echo clean || echo errors)"
printf "  %-11s %s\n" "quickshell" "$(pgrep -x quickshell >/dev/null && echo running || echo stopped)"
printf "  %-11s %s\n" "swaync" "$(pgrep -x swaync >/dev/null && echo running || echo stopped)"
printf "  %-11s %s\n" "wallpaperd" "$(pgrep -x awww-daemon >/dev/null && echo running || echo stopped)"

printf "\n"
printf "  KEYS\n"
printf "  ─────────────────────────────────────\n"
printf "  SUPER+F1        action menu\n"
printf "  SUPER+I         info center\n"
printf "  SUPER+Shift+B   snapshots\n"
printf "  SUPER+Shift+M   maintenance\n"
printf "  SUPER+Ctrl+A    random theme\n"
printf "  SUPER+F12       gaming mode\n"

printf "\n"
printf "  Press Enter to close.\n"
read
'
