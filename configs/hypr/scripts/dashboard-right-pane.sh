#!/usr/bin/env bash

clear

if command -v fastfetch >/dev/null 2>&1; then
  fastfetch
else
  echo "AETHERELIC"
  echo
  uname -a
fi

echo
echo
echo "Type normally here. Matrix + CAVA stay on the left."
echo

exec bash
