#!/usr/bin/env bash

if ! command -v hyprpicker >/dev/null 2>&1; then
  notify-send "Colour picker" "hyprpicker is not installed"
  exit 1
fi

hyprpicker -a
notify-send "Colour copied" "Picked colour copied to clipboard"
