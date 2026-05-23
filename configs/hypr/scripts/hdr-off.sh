#!/usr/bin/env bash

MONITOR="DP-2"

notify-send "HDR" "Turning HDR off for $MONITOR"

hyprctl keyword monitor "$MONITOR,2560x1440@200,0x0,1,bitdepth,8,cm,srgb"

hyprctl keyword render:cm_auto_hdr 0

notify-send "HDR disabled" "Back to SDR/sRGB"
