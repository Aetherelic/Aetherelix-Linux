#!/usr/bin/env bash

ROOT="$HOME/Aetherelic-Rice-Snapshots"
EXPORT_DIR="$HOME/Aetherelic-Rice-Exports"
mkdir -p "$EXPORT_DIR"

LATEST="$(find "$ROOT" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort -r | head -1)"

if [ -z "$LATEST" ]; then
  notify-send "Rice export" "No snapshot found. Create one first."
  exit 1
fi

NAME="aetherelic-rice-$(basename "$LATEST").tar.zst"
OUT="$EXPORT_DIR/$NAME"

tar --zstd -cf "$OUT" -C "$ROOT" "$(basename "$LATEST")"

notify-send "Rice exported" "$OUT"
dolphin "$EXPORT_DIR" >/dev/null 2>&1 & disown
