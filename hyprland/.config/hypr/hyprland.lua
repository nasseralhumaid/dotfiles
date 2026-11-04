-- Main Hyprland Lua entry point. Keep module order explicit.
require("modules.monitors")
require("modules.autostart")
require("modules.environment")
require("modules.decorations")
require("modules.layouts")
require("modules.misc")
require("modules.inputs")
require("modules.keybindings")
require("modules.rules")
require("colours.colours")
do
	local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"
	local file = io.open(path, "r")
	if file then
		file:close()
		dofile(path)
	end
end

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
do local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"; local file = io.open(path, "r"); if file then file:close(); dofile(path) end end
