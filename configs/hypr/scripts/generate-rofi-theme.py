#!/usr/bin/env python3
import json
from pathlib import Path

home = Path.home()
colors_path = home / ".config/quickshell/Colors/colors.json"
out_path = home / ".config/rofi/aetherelic-glass.rasi"

fallback = {
    "background": "#0b0b10",
    "surface": "#15151c",
    "surface_container": "#1a1a24",
    "on_surface": "#f5f0ff",
    "on_surface_variant": "#b8b3c7",
    "primary": "#cba6f7",
    "secondary": "#89b4fa",
    "error": "#f38ba8",
}

try:
    data = json.loads(colors_path.read_text())
except Exception:
    data = {}

def c(*names):
    for name in names:
        if name in data and isinstance(data[name], str):
            return data[name]
    return fallback.get(names[-1], "#ffffff")

bg = c("background")
surface = c("surface", "surface_container", "surface_container_low", "surface_container_high")
fg = c("on_surface")
muted = c("on_surface_variant", "outline", "on_surface")
accent = c("primary")
accent2 = c("secondary", "primary")
error = c("error")

out_path.write_text(f"""
* {{
    bg: {bg};
    surface: {surface};
    fg: {fg};
    muted: {muted};
    accent: {accent};
    accent2: {accent2};
    error: {error};

    background-color: transparent;
    text-color: @fg;
    font: "JetBrainsMono Nerd Font 12";
}}

window {{
    width: 520px;
    border: 1px;
    border-color: @accent;
    border-radius: 22px;
    background-color: @bg;
    padding: 18px;
}}

mainbox {{
    background-color: transparent;
    spacing: 12px;
    padding: 6px;
}}

inputbar {{
    background-color: @surface;
    border-radius: 16px;
    padding: 12px 14px;
    spacing: 10px;
}}

prompt {{
    text-color: @accent;
    font: "JetBrainsMono Nerd Font Bold 12";
}}

entry {{
    placeholder: "Search";
    text-color: @fg;
}}

listview {{
    background-color: transparent;
    border-radius: 16px;
    spacing: 6px;
    lines: 8;
    columns: 1;
    fixed-height: false;
}}

element {{
    background-color: transparent;
    border-radius: 14px;
    padding: 10px 12px;
}}

element selected {{
    background-color: @accent;
    text-color: @bg;
}}

element-text {{
    background-color: transparent;
    text-color: inherit;
}}

element-icon {{
    background-color: transparent;
    size: 28px;
    margin: 0px 10px 0px 0px;
}}

message {{
    background-color: @surface;
    border-radius: 14px;
    padding: 10px;
}}

textbox {{
    text-color: @muted;
}}
""".strip() + "\n")

print(out_path)
