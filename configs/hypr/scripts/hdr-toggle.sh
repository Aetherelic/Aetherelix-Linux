#!/usr/bin/env bash

STATE="$HOME/.cache/aetherelic-hdr-state"
mkdir -p "$HOME/.cache"

if [ "$(cat "$STATE" 2>/dev/null)" = "on" ]; then
  echo "off" > "$STATE"
  bash "$HOME/.config/hypr/scripts/hdr-off.sh"
else
  echo "on" > "$STATE"
  bash "$HOME/.config/hypr/scripts/hdr-on.sh"
fi
