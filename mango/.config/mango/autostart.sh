#!/bin/sh

dbus-update-activation-environment --all WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

/usr/libexec/xdg-desktop-portal >/dev/null 2>&1 &
/usr/libexec/xdg-desktop-portal-wlr >/dev/null 2>&1 &

/usr/libexec/polkit-gnome-authentication-agent-1 >/dev/null 2>&1 &
pipewire >/dev/null 2>&1 &

sunsetr >/dev/null 2>&1 &
awww-daemon >/dev/null 2>&1 &
waybar -c ~/.config/waybar/mango/config.jsonc -s ~/.config/waybar/mango/style.css
swaync >/dev/null 2>&1 &
swayosd-server >/dev/null 2>&1 &
foot --server >/dev/null 2>&1 &
netbird-ui >/dev/null 2>&1 &
GSR_CUDA=1 gsr-ui >/dev/null 2>&1 &
