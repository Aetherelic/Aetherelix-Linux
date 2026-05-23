#!/usr/bin/env bash

ROOT="$HOME/Dotfiles-Aetherelic"
STAMP="$(date +%Y-%m-%d_%H-%M-%S)"
ARCHIVE="$HOME/Dotfiles-Aetherelic-$STAMP.tar.zst"

echo "Preparing export folder..."
rm -rf "$ROOT"
mkdir -p "$ROOT/.config"

copy_one() {
  SRC="$1"
  NAME="$(basename "$SRC")"

  if [ -e "$SRC" ]; then
    echo "Copying $NAME..."
    rsync -a --delete \
      --exclude 'state/' \
      --exclude 'cache/' \
      --exclude '*.log' \
      --exclude '__pycache__/' \
      "$SRC" "$ROOT/.config/"
  else
    echo "Skipping missing $NAME"
  fi
}

copy_one "$HOME/.config/hypr"
copy_one "$HOME/.config/quickshell"
copy_one "$HOME/.config/rofi"
copy_one "$HOME/.config/kitty"
copy_one "$HOME/.config/matugen"
copy_one "$HOME/.config/swaync"
copy_one "$HOME/.config/fastfetch"
copy_one "$HOME/.config/MangoHud"
copy_one "$HOME/.config/cava"

echo "Writing README..."
cat > "$ROOT/README.md" <<'READMEEOF'
# Aetherelic Hyprland Rice

Personal Arch Linux + Hyprland rice backup/export.

## Restore

Copy selected folders from `.config/` into `~/.config/`, then reload Hyprland.

This is a personal backup, not a universal installer.
READMEEOF

cat > "$ROOT/.gitignore" <<'GITEOF'
*.log
*.cache
state/
cache/
__pycache__/
GITEOF

cat > "$ROOT/SYSTEM-INFO.txt" <<INFOEOF
Exported: $(date)
User: $USER
Kernel: $(uname -r)
INFOEOF

echo "Creating archive..."
tar --zstd -cf "$ARCHIVE" -C "$HOME" "Dotfiles-Aetherelic"

echo
echo "Done."
echo "Folder:  $ROOT"
echo "Archive: $ARCHIVE"
