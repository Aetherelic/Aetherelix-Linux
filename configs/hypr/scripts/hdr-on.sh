#!/usr/bin/env bash

MONITOR="DP-2"

notify-send "HDR" "Turning HDR on for $MONITOR"

# Compatible old monitor syntax.
# Keep this simple: bitdepth 10 + cm hdr + SDR brightness/saturation.
hyprctl keyword monitor "$MONITOR,2560x1440@200,0x0,1,bitdepth,10,cm,hdr,sdrbrightness,3.00,sdrsaturation,1.20"

# Colour management options your Hyprland accepted.
hyprctl keyword render:cm_enabled true
hyprctl keyword render:cm_auto_hdr 1

notify-send "HDR enabled" "HDR on: brightness 3.00, saturation 1.20"
