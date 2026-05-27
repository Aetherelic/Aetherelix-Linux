#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"

case "$MODE" in
  enable)
    mkdir -p "$HOME/.config/systemd/user"

    cat > "$HOME/.config/systemd/user/kaizen-quickshell.service" <<SERVICE
[Unit]
Description=Kaizen Quickshell Adaptive Mode
After=graphical-session.target

[Service]
ExecStart=/usr/bin/env QML_XHR_ALLOW_FILE_READ=1 quickshell --path %h/.config/quickshell/shell.qml
Restart=on-failure
RestartSec=2

[Install]
WantedBy=default.target
SERVICE

    systemctl --user daemon-reload
    systemctl --user enable --now kaizen-quickshell.service

    systemctl --user stop kaizen-waybar.service 2>/dev/null || true
    pkill waybar 2>/dev/null || true

    notify-send "Kaizen Adaptive Mode" "Quickshell enabled" 2>/dev/null || true
    ;;

  disable)
    systemctl --user disable --now kaizen-quickshell.service 2>/dev/null || true
    pkill quickshell 2>/dev/null || true

    notify-send "Kaizen Adaptive Mode" "Quickshell disabled" 2>/dev/null || true
    ;;

  *)
    echo "Usage: kaizen-quickshell-mode enable|disable"
    exit 1
    ;;
esac
