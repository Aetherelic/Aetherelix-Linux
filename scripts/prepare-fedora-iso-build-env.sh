#!/usr/bin/env bash
set -euo pipefail

if ! command -v dnf >/dev/null 2>&1; then
  printf "This script must be run on Fedora.\n"
  exit 1
fi

REQUIRED_PACKAGES=(
  lorax
  lorax-lmc-virt
  lorax-lmc-novirt
  pykickstart
  mock
  git
  qemu-kvm
  virt-install
)

OPTIONAL_PACKAGES=(
  spin-kickstarts
)

for pkg in "${REQUIRED_PACKAGES[@]}"; do
  sudo dnf install -y "$pkg"
done

for pkg in "${OPTIONAL_PACKAGES[@]}"; do
  sudo dnf install -y "$pkg" || printf "Optional package skipped: %s\n" "$pkg"
done

if ! command -v livemedia-creator >/dev/null 2>&1; then
  printf "livemedia-creator was not found after installing Fedora image tools.\n"
  exit 1
fi

if ! command -v ksvalidator >/dev/null 2>&1; then
  printf "ksvalidator was not found after installing pykickstart.\n"
  exit 1
fi

sudo usermod -aG mock "$USER" || true

printf "\nFedora ISO build environment prepared.\n"
printf "Log out and back in if this is the first time adding your user to the mock group.\n"
