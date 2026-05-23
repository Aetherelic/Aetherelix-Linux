#!/usr/bin/env bash

if pgrep -x wf-recorder >/dev/null 2>&1; then
  pkill -INT wf-recorder
  notify-send "Recording stopped" "Saved to ~/Videos/Recordings"
else
  notify-send "Recording" "No active recording"
fi
