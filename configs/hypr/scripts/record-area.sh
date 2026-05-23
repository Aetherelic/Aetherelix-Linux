#!/usr/bin/env bash

mkdir -p "$HOME/Videos/Recordings"

if pgrep -x wf-recorder >/dev/null 2>&1; then
  notify-send "Recording" "Already recording. Stop it first."
  exit 0
fi

GEOM="$(slurp)" || exit 0
FILE="$HOME/Videos/Recordings/area-recording-$(date +%Y-%m-%d_%H-%M-%S).mkv"

wf-recorder -g "$GEOM" -f "$FILE" >/tmp/wf-recorder.log 2>&1 &
notify-send "Recording started" "$FILE"
