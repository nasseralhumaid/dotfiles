#!/bin/bash
STATE_DIR="$HOME/.config/hypr/state"
STATE_FILE="$STATE_DIR/hz_mode"
mkdir -p "$STATE_DIR"

# Read current target from state file, default to 144
current_hz="144"
if [ -f "$STATE_FILE" ]; then
  current_hz=$(cat "$STATE_FILE")
fi

# Toggle logic
if [ "$current_hz" -ge 100 ]; then
  echo "60" >"$STATE_FILE"
else
  echo "144" >"$STATE_FILE"
fi

# Reload Hyprland to re-evaluate modules/monitors.lua
hyprctl reload
