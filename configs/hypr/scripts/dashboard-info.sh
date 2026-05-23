#!/usr/bin/env bash

while true; do
  clear

  ACCENT="\033[38;2;203;166;247m"
  BLUE="\033[38;2;137;180;250m"
  GREEN="\033[38;2;166;227;161m"
  MUTED="\033[38;2;150;145;170m"
  RESET="\033[0m"
  BOLD="\033[1m"

  HOST="$(hostname)"
  KERNEL="$(uname -r)"
  WM="${XDG_CURRENT_DESKTOP:-Hyprland}"
  UPTIME="$(uptime -p | sed 's/up //')"
  MEM="$(free -h | awk '/Mem:/ {print $3 " / " $2}')"
  DISK="$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')"
  CPU="$(lscpu 2>/dev/null | awk -F: '/Model name/ {gsub(/^ +/, "", $2); print $2; exit}')"
  GPU="$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | head -1)"
  TRACK="$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null || echo 'No active media')"
  WALL="$(readlink ~/.config/hypr/current_wallpaper 2>/dev/null | xargs basename 2>/dev/null)"

  echo -e "${ACCENT}${BOLD}        /\\"
  echo -e "       /  \\"
  echo -e "      / /\\ \\"
  echo -e "     / ____ \\"
  echo -e "    /_/    \\_\\${RESET}"
  echo
  echo -e "${BOLD}${ACCENT}AETHERELIC // TERMINAL DASHBOARD${RESET}"
  echo -e "${MUTED}────────────────────────────────────${RESET}"
  echo
  echo -e "${BLUE}HOST${RESET}     → ${HOST}"
  echo -e "${BLUE}WM${RESET}       → ${WM}"
  echo -e "${BLUE}KERNEL${RESET}   → ${KERNEL}"
  echo -e "${BLUE}UPTIME${RESET}   → ${UPTIME}"
  echo
  echo -e "${GREEN}CPU${RESET}      → ${CPU:-Unknown}"
  echo -e "${GREEN}GPU${RESET}      → ${GPU:-Unknown}"
  echo -e "${GREEN}MEMORY${RESET}   → ${MEM}"
  echo -e "${GREEN}DISK${RESET}     → ${DISK}"
  echo
  echo -e "${ACCENT}MEDIA${RESET}    → ${TRACK}"
  echo -e "${ACCENT}WALL${RESET}     → ${WALL:-unknown}"
  echo
  echo -e "${MUTED}SEE YOU SPACE COWBOY...${RESET}"

  sleep 4
done
