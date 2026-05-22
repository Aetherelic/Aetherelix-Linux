#!/usr/bin/env bash
set -euo pipefail

if ! command -v dnf >/dev/null 2>&1; then
  printf "This installer is for Fedora-based systems only.\n"
  exit 1
fi

if [ -f /etc/os-release ]; then
  . /etc/os-release
else
  printf "Could not detect OS.\n"
  exit 1
fi

case "${ID:-}" in
  fedora)
    ;;
  *)
    printf "This installer currently supports Fedora only. Detected: %s\n" "${ID:-unknown}"
    exit 1
    ;;
esac

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo dnf upgrade --refresh -y
sudo dnf install -y dnf-plugins-core

# RPM Fusion is needed for common gaming/media packages Fedora does not ship directly.
sudo dnf install -y \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${VERSION_ID}.noarch.rpm" \
  "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${VERSION_ID}.noarch.rpm"

sudo dnf group upgrade -y core

install_package_list() {
  local file="$1"
  if [ -f "$file" ]; then
    sudo dnf install -y $(grep -vE '^\s*#|^\s*$' "$file")
  fi
}

install_package_list "$ROOT_DIR/packages/base.txt"
install_package_list "$ROOT_DIR/packages/desktop.txt"
install_package_list "$ROOT_DIR/packages/gaming.txt"
install_package_list "$ROOT_DIR/packages/productivity.txt"

mkdir -p "$HOME/.config"

copy_config_dir() {
  local name="$1"
  if [ -d "$ROOT_DIR/configs/$name" ] && [ "$(find "$ROOT_DIR/configs/$name" -mindepth 1 | wc -l)" -gt 0 ]; then
    rm -rf "$HOME/.config/$name"
    cp -r "$ROOT_DIR/configs/$name" "$HOME/.config/$name"
  fi
}

copy_config_dir hypr
copy_config_dir quickshell
copy_config_dir rofi
copy_config_dir kitty
copy_config_dir fastfetch

systemctl --user daemon-reload || true

printf "\nAetherOS Fedora Hyprland base install complete.\n"
printf "Reboot, then choose Hyprland from your login screen if available.\n"
