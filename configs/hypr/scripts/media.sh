#!/usr/bin/env bash

ACTION="$1"

case "$ACTION" in
  play-pause)
    playerctl play-pause 2>/dev/null
    ;;
  next)
    playerctl next 2>/dev/null
    ;;
  previous)
    playerctl previous 2>/dev/null
    ;;
  stop)
    playerctl stop 2>/dev/null
    ;;
esac

META="$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null)"

if [ -n "$META" ]; then
  notify-send -h string:x-canonical-private-synchronous:media "Media" "$META"
else
  notify-send -h string:x-canonical-private-synchronous:media "Media" "No active player"
fi
