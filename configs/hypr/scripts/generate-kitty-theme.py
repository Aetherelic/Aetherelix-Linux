#!/usr/bin/env python3
from pathlib import Path
import json

home = Path.home()
colors_path = home / ".config/quickshell/Colors/colors.json"
theme_path = home / ".config/kitty/aetherelic-adaptive.conf"
kitty_conf = home / ".config/kitty/kitty.conf"

def clean(value, fallback):
    h = str(value or fallback).strip().lstrip("#")
    if len(h) != 6:
        h = fallback.strip().lstrip("#")
    return "#" + h.upper()

try:
    c = json.loads(colors_path.read_text())
except Exception:
    c = {}

bg = clean(c.get("background"), "#0B0D10")
fg = clean(c.get("on_surface"), "#E8E8EA")
primary = clean(c.get("primary"), "#CBA6F7")
secondary = clean(c.get("secondary"), "#89B4FA")
tertiary = clean(c.get("tertiary"), "#F5C2E7")
surface = clean(c.get("surface_container"), "#151820")
muted = clean(c.get("on_surface_variant"), "#A0A0A8")

theme = f"""# Auto-generated Aetherelic Kitty theme

foreground {fg}
background {bg}
cursor {primary}
selection_foreground {bg}
selection_background {primary}

color0  {surface}
color1  #F38BA8
color2  #A6E3A1
color3  #F9E2AF
color4  {secondary}
color5  {primary}
color6  {tertiary}
color7  {fg}
color8  {muted}
color9  #F38BA8
color10 #A6E3A1
color11 #F9E2AF
color12 {secondary}
color13 {primary}
color14 {tertiary}
color15 #FFFFFF
"""

theme_path.write_text(theme)

s = kitty_conf.read_text() if kitty_conf.exists() else ""
include_line = "include aetherelic-adaptive.conf"
if include_line not in s:
    s = s.rstrip() + "\n\n# Adaptive wallpaper colours\n" + include_line + "\n"
    kitty_conf.write_text(s)

print(f"Wrote {theme_path}")
