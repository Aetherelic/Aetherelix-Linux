#!/usr/bin/env bash

OUT="$HOME/Documents/Aetherelic/AETHERELIC-KEYBINDS.md"

mkdir -p "$(dirname "$OUT")"

cat > "$OUT" <<'MD'
# Aetherelic Hyprland Keybinds

## Core
| Keybind | Action |
|---|---|
| `SUPER + Enter` | Terminal |
| `SUPER + Shift + Enter` | File manager |
| `SUPER + Q` | Close active window |
| `SUPER + F` | Fullscreen active window |
| `SUPER + Shift + F` | Firefox |
| `SUPER + V` | Toggle floating |
| `SUPER + Shift + V` | Center window |
| `SUPER + Arrow` | Move focus |
| `SUPER + Shift + Arrow` | Move window |
| `SUPER + Alt + Arrow` | Nudge floating window |

## Rice / Menus
| Keybind | Action |
|---|---|
| `SUPER + F1` | Main action menu |
| `SUPER + W` | Welcome/session popup |
| `SUPER + I` | Info Center |
| `SUPER + Shift + M` | Maintenance menu |
| `SUPER + Shift + B` | Rice snapshot/restore |
| `SUPER + Shift + R` | Repair/refresh rice |
| `SUPER + Shift + A` | Wallpaper/adaptive theme picker |
| `SUPER + Ctrl + A` | Random adaptive theme |

## Terminal / System
| Keybind | Action |
|---|---|
| `SUPER + key above Tab` | Drop-down glass terminal |
| `SUPER + Shift + key above Tab` | Floating btop monitor |
| `SUPER + K` | Notes/todo menu |
| `SUPER + Shift + K` | Focus timer |
| `SUPER + Ctrl + P` | Colour picker |
| `SUPER + .` | Emoji picker |

## Screenshots / Recording
| Keybind | Action |
|---|---|
| `Print` | Area screenshot with editor |
| `SUPER + Print` | Full screenshot with editor |
| `SUPER + F1 → Record area` | Area screen recording |
| `SUPER + F1 → Record full screen` | Full screen recording |
| `SUPER + F1 → Stop recording` | Stop recording |

## Audio / Media
| Keybind | Action |
|---|---|
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86AudioMute` | Mute |
| `XF86AudioPlay` | Play/pause |
| `XF86AudioNext` | Next track |
| `XF86AudioPrev` | Previous track |
| `SUPER + Ctrl + Space` | Play/pause |
| `SUPER + Ctrl + Right` | Next track |
| `SUPER + Ctrl + Left` | Previous track |

## Profiles
| Keybind | Action |
|---|---|
| `SUPER + G` | Gaming profile |
| `SUPER + Shift + G` | Leave gaming profile |
| `SUPER + O` | Recording profile |
| `SUPER + Y` | Media profile |
| `SUPER + F12` | Toggle gaming mode |
| `SUPER + Shift + C` | Toggle caffeine |
| `SUPER + Ctrl + Z` | Turn screens off |

## Power
| Keybind | Action |
|---|---|
| `SUPER + Shift + L` | Power menu |
MD

{
  echo
  echo "## Raw Hyprland binds"
  echo
  echo '```text'
  grep -nE "^bind|^bindm|^bindl|^bindel" "$HOME/.config/hypr/hyprland.conf"
  echo '```'
} >> "$OUT"

notify-send "Keybind cheat sheet exported" "$OUT"
echo "$OUT"
