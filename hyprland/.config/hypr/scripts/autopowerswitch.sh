#!/bin/bash

MONITOR="eDP-1"
SCALE="1"

# Fallback defaults if variables are somehow empty
MONITOR="${MONITOR:-eDP-1}"
SCALE="${SCALE:-1}"

# Check AC power status via upower
if upower -i $(upower -e | grep 'line-power') | grep -q "online: yes"; then
  hyprctl eval "hl.monitor({ output = '$MONITOR', mode = 'preferred@144', position = 'auto', scale = $SCALE })"
else
  hyprctl eval "hl.monitor({ output = '$MONITOR', mode = 'preferred@60', position = 'auto', scale = $SCALE })"
fi
