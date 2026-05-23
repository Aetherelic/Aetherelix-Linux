#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-}"
REPO_DIR="${KAIZEN_REPO_DIR:-$HOME/Kaizen-Linux}"

if [ -z "$PROFILE" ]; then
  echo "Usage: kaizen-install-profile <gaming|productivity|all>"
  exit 1
fi

if [ ! -d "$REPO_DIR" ]; then
  echo "Kaizen repo not found at: $REPO_DIR"
  echo "Clone it with:"
  echo "git clone https://github.com/Aetherelic/Kaizen-Linux.git $REPO_DIR"
  exit 1
fi

install_dnf_list() {
  local file="$1"
  [ -f "$file" ] || return 0

  while IFS= read -r pkg; do
    case "$pkg" in
      ""|\#*) continue ;;
    esac
    sudo dnf install -y "$pkg" || true
  done < "$file"
}

install_flatpak_list() {
  local file="$1"
  [ -f "$file" ] || return 0

  flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo || true

  while IFS= read -r app; do
    case "$app" in
      ""|\#*) continue ;;
    esac
    flatpak install --user -y flathub "$app" || true
  done < "$file"
}

cd "$REPO_DIR"

case "$PROFILE" in
  gaming)
    install_dnf_list packages/gaming.txt
    ;;
  productivity)
    install_dnf_list packages/productivity-dnf.txt
    install_flatpak_list packages/productivity-flatpak.txt
    ;;
  all)
    install_dnf_list packages/gaming.txt
    install_dnf_list packages/productivity-dnf.txt
    install_flatpak_list packages/productivity-flatpak.txt
    ;;
  *)
    echo "Unknown profile: $PROFILE"
    echo "Use: gaming, productivity, or all"
    exit 1
    ;;
esac

echo
echo "Kaizen $PROFILE profile install complete."
