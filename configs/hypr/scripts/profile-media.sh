#!/usr/bin/env bash

hyprctl dispatch workspace 6

# Spotify if available
if command -v spotify >/dev/null 2>&1 && ! pgrep -x spotify >/dev/null 2>&1; then
  spotify >/tmp/spotify-aetherelic.log 2>&1 & disown
fi

# Vesktop if installed as Flatpak
if command -v flatpak >/dev/null 2>&1 && ! pgrep -f "dev.vencord.Vesktop" >/dev/null 2>&1; then
  flatpak run dev.vencord.Vesktop >/tmp/vesktop-aetherelic.log 2>&1 & disown
fi

notify-send "Media profile" "Workspace 6 ready"
