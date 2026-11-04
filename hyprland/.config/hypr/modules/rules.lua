hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Keep the built-in laptop panel bound to its workspaces. The monitor field
-- must match the description form reported by hyprctl (desc:...).
for _, i in ipairs({1, 3, 4}) do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "desc:AU Optronics 0xAF90",
	})
end

for _, i in ipairs({ 2, 5, 6 }) do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "desc:GWD ARZOPA 000000000000",
	})
end


hl.layer_rule({
	match = { namespace = "swaync-control-center" },
	blur = true,
	ignore_alpha = 0.2,
})

hl.layer_rule({
	match = { namespace = "swaync-notification-window" },
	blur = true,
	ignore_alpha = 0.2,
})
