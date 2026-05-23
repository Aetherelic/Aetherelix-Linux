#!/usr/bin/env bash

if ! brightnessctl devices >/dev/null 2>&1; then
  notify-send "Brightness" "No brightness device found"
  exit 0
fi

case "$1" in
  up)
    brightnessctl set +5% >/dev/null
    ;;
  down)
    brightnessctl set 5%- >/dev/null
    ;;
esac

PERCENT="$(brightnessctl -m | awk -F, '{gsub(/%/, "", $4); print $4}' | head -1)"
notify-send -h string:x-canonical-private-synchronous:brightness "Brightness" "󰃠 ${PERCENT}%"
