return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	dependencies = { "nvim-mini/mini.icons" },
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostic disable: missing-fields
	opts = {},
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Fuzzy Find Files in the Current Working Directory",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Grep Through the Current Working Directory",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").builtin()
			end,
			desc = "Fuzzy Find Built In Fuzzy Finders",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "Fuzzy Find Neovim Help",
		},
		{
			"<leader>fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "Fuzzy Find the Keymap",
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "Find the Current Word",
		},
		{
			"<leader>fob",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Fuzzy Find Current Open Buffers",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").lgrep_curbuf()
			end,
			desc = "Grep Within the Current File",
		},
	},
}
