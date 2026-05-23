#!/usr/bin/env bash

hyprctl dispatch workspace 7

if command -v obs >/dev/null 2>&1 && ! pgrep -x obs >/dev/null 2>&1; then
  obs >/tmp/obs-aetherelic.log 2>&1 & disown
fi

dolphin "$HOME/Videos/Recordings" >/dev/null 2>&1 & disown

notify-send "Recording profile" "Workspace 7 ready"
