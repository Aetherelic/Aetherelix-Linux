#!/usr/bin/env bash

CITY="${AETHERELIC_WEATHER_CITY:-London}"

kitty --class aetherelic-info-popup --title "Aetherelic Weather" \
  --override background_opacity=0.64 \
  --override dynamic_background_opacity=yes \
  --override window_padding_width=16 \
  bash -lc "
clear
echo '╭────────────────────────────────────╮'
echo '│           Aetherelic Weather        │'
echo '╰────────────────────────────────────╯'
echo
echo 'City: $CITY'
echo
curl -s 'wttr.in/$CITY?0' || echo 'Weather failed. Check internet or edit city in popup-weather.sh.'
echo
echo 'Press Enter to close.'
read
"
