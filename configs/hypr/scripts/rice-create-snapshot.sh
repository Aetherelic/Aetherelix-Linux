#!/usr/bin/env bash

ROOT="$HOME/Aetherelic-Rice-Snapshots"
TS="$(date +%Y-%m-%d_%H-%M-%S)"
SNAP="$ROOT/$TS"

mkdir -p "$SNAP"

cp -a "$HOME/.config/hypr" "$SNAP/hypr"
cp -a "$HOME/.config/quickshell" "$SNAP/quickshell" 2>/dev/null || true
cp -a "$HOME/.config/rofi" "$SNAP/rofi" 2>/dev/null || true
cp -a "$HOME/.config/matugen" "$SNAP/matugen" 2>/dev/null || true
cp -a "$HOME/.config/swaync" "$SNAP/swaync" 2>/dev/null || true
cp -a "$HOME/.config/MangoHud" "$SNAP/MangoHud" 2>/dev/null || true
cp -a "$HOME/.config/cava" "$SNAP/cava" 2>/dev/null || true
cp -a "$HOME/.config/kitty" "$SNAP/kitty" 2>/dev/null || true
cp -a "$HOME/.config/fastfetch" "$SNAP/fastfetch" 2>/dev/null || true

{
  echo "Aetherelic Rice Snapshot"
  echo "Created: $TS"
  echo
  echo "Kernel:"
  uname -r
  echo
  echo "Hyprland errors:"
  hyprctl configerrors
  echo
  echo "Current wallpaper:"
  ls -l "$HOME/.config/hypr/current_wallpaper" 2>/dev/null || true
  echo
  echo "Important processes:"
  pgrep -a quickshell || true
  pgrep -a swaync || true
  pgrep -a swayidle || true
  pgrep -a awww-daemon || true
} > "$SNAP/README-SNAPSHOT.txt"

notify-send "Rice snapshot created" "$SNAP"
echo "$SNAP"
