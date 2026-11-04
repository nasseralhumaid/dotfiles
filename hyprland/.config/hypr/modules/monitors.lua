local hz = "144"
local state_file = os.getenv("HOME") .. "/.config/hypr/state/hz_mode"
local f = io.open(state_file, "r")
if f then
	hz = f:read("*all"):gsub("%s+", "")
	f:close()
end

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

hl.monitor({
	output = "eDP-1",
	mode = "preferred@" .. hz,
	position = "auto",
	scale = 1,
})
