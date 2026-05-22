#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

bash -n install.sh

required_files=(
  "install.sh"
  "README.md"
  "packages/base.txt"
  "packages/desktop-common.txt"
  "packages/hyprland.txt"
  "packages/gaming.txt"
  "packages/productivity-dnf.txt"
  "packages/productivity-flatpak.txt"
  "packages/wallpaper-optional.txt"
  "configs/hypr/hyprland.conf"
  "configs/kitty/kitty.conf"
  "configs/rofi/config.rasi"
  "configs/rofi/aetherelix.rasi"
  "configs/waybar/config.jsonc"
  "configs/waybar/style.css"
  "configs/fastfetch/config.jsonc"
  "docs/FIRSTBOOT.md"
)

for file in "${required_files[@]}"; do
  test -f "$file"
done

grep -q "mate-polkit" packages/desktop-common.txt
grep -q "hyprpaper" packages/wallpaper-optional.txt
grep -q "bind = CTRL ALT, T" configs/hypr/hyprland.conf
grep -q "bind = ALT, SPACE" configs/hypr/hyprland.conf
grep -q "exec-once = waybar" configs/hypr/hyprland.conf
grep -q "copy_config_dir waybar" install.sh

if grep -qE "^(swww|polkit-gnome)$" packages/desktop-common.txt; then
  printf "Deprecated Fedora-incompatible package found in desktop-common.txt\n"
  exit 1
fi

printf "Aetherelix validation passed.\n"
