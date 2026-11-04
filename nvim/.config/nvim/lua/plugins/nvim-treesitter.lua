return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false, -- Main branch strongly recommends lazy = false so queries load correctly
		init = function()
			-- Map the 'qml' filetype to the 'qmljs' parser
			vim.treesitter.language.register("qmljs", "qml")
			-- QML indentation is handled by $VIMRUNTIME/indent/qml.vim.
			-- Do not use 'cindent' here: it treats every QML property line as an
			-- unterminated C statement, so each line gains another indent level.
		end,
		config = function()
			local ts = require("nvim-treesitter")

			-- Direct installation on the main branch API
			ts.install({
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"markdown",
				"markdown_inline",
				"python",
				"c",
				"cpp",
				"qmljs",
			})
		end,
	},
}
