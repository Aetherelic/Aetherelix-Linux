#!/usr/bin/env python3
from pathlib import Path
import json

home = Path.home()
colors_path = home / ".config/quickshell/Colors/colors.json"
out = home / ".config/hypr/configs/aetherelic-adaptive-hypr.conf"

def clean(hex_color, fallback):
    h = str(hex_color or fallback).strip().lstrip("#")
    if len(h) != 6:
        h = fallback.strip().lstrip("#")
    return h

try:
    c = json.loads(colors_path.read_text())
except Exception:
    c = {}

primary = clean(c.get("primary"), "#cba6f7")
secondary = clean(c.get("secondary"), "#89b4fa")
tertiary = clean(c.get("tertiary"), "#f5c2e7")
surface = clean(c.get("surface_container"), "#181825")
background = clean(c.get("background"), "#0b0b10")

conf = f"""# =========================================================
# Aetherelic adaptive Hyprland polish
# Auto-generated from matugen / Quickshell colours
# =========================================================

general {{
    gaps_in = 5
    gaps_out = 10
    border_size = 2

    col.active_border = rgba({primary}ee) rgba({secondary}dd) rgba({tertiary}cc) 45deg
    col.inactive_border = rgba({surface}99)
}}

decoration {{
    rounding = 16

    shadow {{
        enabled = true
        range = 24
        render_power = 3
        color = rgba({background}99)
        color_inactive = rgba({background}66)
    }}
}}
"""

out.write_text(conf)
print(f"Wrote {out}")
