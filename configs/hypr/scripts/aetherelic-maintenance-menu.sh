#!/usr/bin/env bash

THEME="$HOME/.config/rofi/aetherelic-glass.rasi"
[ -f "$THEME" ] || THEME="$HOME/.config/rofi/aetherelic-adaptive.rasi"

confirm() {
  local prompt="$1"
  local yes="Yes, do it"
  local picked
  picked="$(
cat <<MENU | rofi -dmenu -i -p "$prompt" -theme "$THEME"
$yes
Cancel
MENU
)"
  [ "$picked" = "$yes" ]
}

choice="$(
cat <<'MENU' | rofi -dmenu -i -p "Maintenance" -theme "$THEME"
󰚰  Check updates
󰚰  Update system
󰃢  Clean pacman cache
󰮯  List orphan packages
󰮯  Remove orphan packages
󰋼  Clean journal logs
  Open cache folders
󰌨  Rice health check
MENU
)"

case "$choice" in
  *"Check updates"*)
    bash "$HOME/.config/hypr/scripts/update-check.sh"
    ;;

  *"Update system"*)
    if confirm "Update system?"; then
      kitty --class aetherelic-maintenance --title "Aetherelic System Update" bash -lc '
        clear
        echo "=== Aetherelic system update ==="
        echo
        yay -Syu
        echo
        echo "Press Enter to close."
        read
      '
    fi
    ;;

  *"Clean pacman cache"*)
    if confirm "Clean pacman cache?"; then
      kitty --class aetherelic-maintenance --title "Aetherelic Cache Clean" bash -lc '
        clear
        echo "=== Cleaning pacman cache ==="
        echo "Keeping latest 2 versions of packages..."
        echo
        sudo paccache -rk2
        echo
        echo "Removing cached uninstalled packages..."
        sudo paccache -ruk0
        echo
        echo "Done. Press Enter to close."
        read
      '
    fi
    ;;

  *"List orphan packages"*)
    kitty --class aetherelic-maintenance --title "Aetherelic Orphans" bash -lc '
      clear
      echo "=== Orphan packages ==="
      echo
      pacman -Qtdq 2>/dev/null || echo "No orphan packages."
      echo
      echo "Press Enter to close."
      read
    '
    ;;

  *"Remove orphan packages"*)
    if confirm "Remove orphan packages?"; then
      kitty --class aetherelic-maintenance --title "Aetherelic Remove Orphans" bash -lc '
        clear
        echo "=== Removing orphan packages ==="
        echo
        ORPHANS="$(pacman -Qtdq 2>/dev/null)"
        if [ -z "$ORPHANS" ]; then
          echo "No orphan packages."
        else
          sudo pacman -Rns $ORPHANS
        fi
        echo
        echo "Press Enter to close."
        read
      '
    fi
    ;;

  *"Clean journal logs"*)
    if confirm "Vacuum journal logs?"; then
      kitty --class aetherelic-maintenance --title "Aetherelic Journal Clean" bash -lc '
        clear
        echo "=== Cleaning journal logs ==="
        echo "Keeping last 7 days..."
        echo
        sudo journalctl --vacuum-time=7d
        echo
        echo "Press Enter to close."
        read
      '
    fi
    ;;

  *"Open cache folders"*)
    dolphin "$HOME/.cache" >/dev/null 2>&1 & disown
    ;;

  *"Rice health check"*)
    bash "$HOME/.config/hypr/scripts/rice-health.sh"
    ;;
esac
