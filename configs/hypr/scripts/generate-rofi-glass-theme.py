#!/usr/bin/env python3
from pathlib import Path
import json

home = Path.home()
colors_path = home / ".config/quickshell/Colors/colors.json"
out = home / ".config/rofi/aetherelic-glass.rasi"

def clean(value, fallback):
    h = str(value or fallback).strip().lstrip("#")
    if len(h) != 6:
        h = fallback.strip().lstrip("#")
    return h.upper()

try:
    c = json.loads(colors_path.read_text())
except Exception:
    c = {}

bg = clean(c.get("background"), "#0B0B10")
surface = clean(c.get("surface_container"), "#181825")
surface2 = clean(c.get("surface_container_high"), "#1E1E2E")
fg = clean(c.get("on_surface"), "#FFFFFF")
muted = clean(c.get("on_surface_variant"), "#B8B8C0")
accent = clean(c.get("primary"), "#CBA6F7")
secondary = clean(c.get("secondary"), "#89B4FA")

theme = f'''
configuration {{
    show-icons: true;
    display-drun: "Apps";
    display-run: "Run";
    drun-display-format: "{{icon}} {{name}}";
    font: "JetBrainsMono Nerd Font 12";
}}

* {{
    bg:       #{bg}E6;
    surface:  #{surface}DD;
    surface2: #{surface2}F0;
    fg:       #{fg}FF;
    muted:    #{muted}CC;
    accent:   #{accent}FF;
    accent2:  #{secondary}FF;

    background-color: transparent;
    text-color: @fg;

    margin: 0;
    padding: 0;
    spacing: 0;
}}

window {{
    width: 760px;
    background-color: @bg;
    border: 2px;
    border-color: @accent;
    border-radius: 24px;
    padding: 18px;
}}

mainbox {{
    background-color: transparent;
    spacing: 14px;
}}

inputbar {{
    background-color: @surface;
    border: 1px;
    border-color: @accent;
    border-radius: 18px;
    padding: 12px 16px;
    spacing: 12px;
}}

prompt {{
    text-color: @accent;
    font: "JetBrainsMono Nerd Font Bold 12";
}}

entry {{
    placeholder: "Search...";
    placeholder-color: @muted;
    text-color: @fg;
}}

listview {{
    background-color: transparent;
    columns: 1;
    lines: 9;
    spacing: 8px;
    fixed-height: false;
}}

element {{
    background-color: transparent;
    border-radius: 16px;
    padding: 10px 12px;
    spacing: 12px;
}}

element selected {{
    background-color: @surface2;
    border: 1px;
    border-color: @accent2;
}}

element-icon {{
    size: 28px;
    background-color: transparent;
}}

element-text {{
    background-color: transparent;
    text-color: @fg;
    vertical-align: 0.5;
}}

element selected element-text {{
    text-color: @accent;
}}

message {{
    background-color: @surface;
    border-radius: 16px;
    padding: 12px;
}}

textbox {{
    text-color: @muted;
}}
'''

out.write_text(theme.strip() + "\n")
print(f"Wrote {out}")
