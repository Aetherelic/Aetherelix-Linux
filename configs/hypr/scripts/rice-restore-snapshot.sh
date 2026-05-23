#!/usr/bin/env bash

ROOT="$HOME/Aetherelic-Rice-Snapshots"
THEME="$HOME/.config/rofi/aetherelic-glass.rasi"

[ ! -d "$ROOT" ] && notify-send "Rice restore" "No snapshots folder found" && exit 1

choice="$(
  find "$ROOT" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort -r |
  rofi -dmenu -i -p "Restore snapshot" -theme "$THEME"
)"

[ -z "$choice" ] && exit 0

SNAP="$ROOT/$choice"

confirm="$(
cat <<MENU | rofi -dmenu -i -p "Restore $choice?" -theme "$THEME"
Yes, restore this snapshot
No, cancel
MENU
)"

[ "$confirm" != "Yes, restore this snapshot" ] && exit 0

mkdir -p "$HOME/arch-working-backup"
PRE="$HOME/arch-working-backup/pre-restore-$(date +%Y-%m-%d_%H-%M-%S)"
mkdir -p "$PRE"

cp -a "$HOME/.config/hypr" "$PRE/hypr" 2>/dev/null || true
cp -a "$HOME/.config/quickshell" "$PRE/quickshell" 2>/dev/null || true
cp -a "$HOME/.config/rofi" "$PRE/rofi" 2>/dev/null || true
cp -a "$HOME/.config/matugen" "$PRE/matugen" 2>/dev/null || true
cp -a "$HOME/.config/swaync" "$PRE/swaync" 2>/dev/null || true
cp -a "$HOME/.config/MangoHud" "$PRE/MangoHud" 2>/dev/null || true
cp -a "$HOME/.config/cava" "$PRE/cava" 2>/dev/null || true
cp -a "$HOME/.config/kitty" "$PRE/kitty" 2>/dev/null || true
cp -a "$HOME/.config/fastfetch" "$PRE/fastfetch" 2>/dev/null || true

[ -d "$SNAP/hypr" ] && rm -rf "$HOME/.config/hypr" && cp -a "$SNAP/hypr" "$HOME/.config/hypr"
[ -d "$SNAP/quickshell" ] && rm -rf "$HOME/.config/quickshell" && cp -a "$SNAP/quickshell" "$HOME/.config/quickshell"
[ -d "$SNAP/rofi" ] && rm -rf "$HOME/.config/rofi" && cp -a "$SNAP/rofi" "$HOME/.config/rofi"
[ -d "$SNAP/matugen" ] && rm -rf "$HOME/.config/matugen" && cp -a "$SNAP/matugen" "$HOME/.config/matugen"
[ -d "$SNAP/swaync" ] && rm -rf "$HOME/.config/swaync" && cp -a "$SNAP/swaync" "$HOME/.config/swaync"
[ -d "$SNAP/MangoHud" ] && rm -rf "$HOME/.config/MangoHud" && cp -a "$SNAP/MangoHud" "$HOME/.config/MangoHud"
[ -d "$SNAP/cava" ] && rm -rf "$HOME/.config/cava" && cp -a "$SNAP/cava" "$HOME/.config/cava"
[ -d "$SNAP/kitty" ] && rm -rf "$HOME/.config/kitty" && cp -a "$SNAP/kitty" "$HOME/.config/kitty"
[ -d "$SNAP/fastfetch" ] && rm -rf "$HOME/.config/fastfetch" && cp -a "$SNAP/fastfetch" "$HOME/.config/fastfetch"

pkill quickshell 2>/dev/null || true
QML_XHR_ALLOW_FILE_READ=1 setsid quickshell --path "$HOME/.config/quickshell/shell.qml" >/tmp/quickshell.log 2>&1 & disown

hyprctl reload

notify-send "Rice restored" "$choice"
