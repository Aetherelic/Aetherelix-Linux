#!/usr/bin/env bash

case "$1" in
  up)
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    ;;
  down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    ;;
  mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
esac

VOL="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)"
PERCENT="$(echo "$VOL" | awk '{printf "%d", $2 * 100}')"

if echo "$VOL" | grep -q MUTED; then
  notify-send -h string:x-canonical-private-synchronous:volume "Volume muted" "󰖁 Muted"
else
  notify-send -h string:x-canonical-private-synchronous:volume "Volume" "󰕾 ${PERCENT}%"
fi
