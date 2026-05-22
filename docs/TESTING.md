# Testing Guide

## Current goal

Test the post-install script inside a clean Fedora VM before trying to build an ISO.

## Recommended test flow

1. Install Fedora Workstation in a VM.
2. Update the system.
3. Clone this repo.
4. Run ./install.sh
5. Reboot.
6. Choose Hyprland from the login screen.

## Safer minimal test

Run ./install.sh --no-gaming --no-productivity

## Notes

Do not test the full installer on your main Arch machine.
This project targets Fedora.
