#!/usr/bin/env bash

STATE="$HOME/.cache/aetherelic-welcome-last"
mkdir -p "$HOME/.cache"

TODAY="$(date +%Y-%m-%d)"
LAST="$(cat "$STATE" 2>/dev/null || true)"

if [ "$LAST" = "$TODAY" ]; then
  exit 0
fi

echo "$TODAY" > "$STATE"

sleep 4
bash "$HOME/.config/hypr/scripts/aetherelic-welcome-launch.sh"
