return {
	"echasnovski/mini.icons",
	lazy = true,
	opts = {},
	config = function(_, opts)
		local mini_icons = require("mini.icons")
		mini_icons.setup(opts)
		mini_icons.mock_nvim_web_devicons() -- Redirects all nvim-web-devicons calls to mini.icons
	end,
}
