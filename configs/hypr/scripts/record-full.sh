#!/usr/bin/env bash

mkdir -p "$HOME/Videos/Recordings"

if pgrep -x wf-recorder >/dev/null 2>&1; then
  notify-send "Recording" "Already recording. Stop it first."
  exit 0
fi

FILE="$HOME/Videos/Recordings/full-recording-$(date +%Y-%m-%d_%H-%M-%S).mkv"

wf-recorder -f "$FILE" >/tmp/wf-recorder.log 2>&1 &
notify-send "Full recording started" "$FILE"
