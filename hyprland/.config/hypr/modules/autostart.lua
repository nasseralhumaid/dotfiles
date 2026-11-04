hl.on("hyprland.start", function()
	-- 1. Essential DBus & Portal Initialization (Must run FIRST)
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/libexec/xdg-desktop-portal-hyprland &")
	hl.exec_cmd("/usr/libexec/xdg-desktop-portal &")

	-- 2. Polkit & Core Audio Services
	hl.exec_cmd("/usr/libexec/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("pipewire")

	-- 3. Desktop Shell & Utilities
	hl.exec_cmd("sunsetr")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("waybar")
	hl.exec_cmd("swaync")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("swayosd-server")

	-- 4. Screen Recorder UI (Starts AFTER Portals & DBus are online)
	hl.exec_cmd("GSR_CUDA=1 gsr-ui")
end)
