#!/bin/bash

pkill -9 waybar
pkill -9 swaync
nohup waybar >/dev/null 2>&1 &
nohup swaync >/dev/null 2>&1 &
