#!/usr/bin/env bash
set -u

escape_json() {
  sed 's/\\/\\\\/g; s/"/\\"/g'
}

if command -v playerctl >/dev/null 2>&1; then
  status="$(playerctl status 2>/dev/null || true)"
  if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
    artist="$(playerctl metadata artist 2>/dev/null || true)"
    title="$(playerctl metadata title 2>/dev/null || true)"

    text="$title"
    [ -n "$artist" ] && text="$artist — $title"
    [ -z "$text" ] && text="Media"

    if [ "$status" = "Paused" ]; then
      class="paused"
      text="Paused — $text"
    else
      class="playing"
    fi

    text="$(printf '%s' "$text" | cut -c1-70 | escape_json)"
    printf '{"text":"%s","class":"%s","tooltip":"Left click play/pause • Right click next"}\n' "$text" "$class"
    exit 0
  fi
fi

if command -v hyprctl >/dev/null 2>&1; then
  title="$(hyprctl activewindow -j 2>/dev/null | python3 -c 'import json,sys; print(json.load(sys.stdin).get("title",""))' 2>/dev/null || true)"
  if [ -n "$title" ] && [ "$title" != "null" ]; then
    title="$(printf '%s' "$title" | cut -c1-70 | escape_json)"
    printf '{"text":"%s","class":"window","tooltip":"Focused window"}\n' "$title"
    exit 0
  fi
fi

text="$(date '+%a %d %b  %H:%M')"
printf '{"text":"%s","class":"idle","tooltip":"Kaizen Linux"}\n' "$text"
