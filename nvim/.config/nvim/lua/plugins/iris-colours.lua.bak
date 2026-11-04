return {
	dir = vim.fn.stdpath("config"),
	name = "iris-wallpaper-theme",
	lazy = false,
	priority = 1000,
	config = function()
		local theme_file = vim.fn.expand("~/.cache/iris/nvim-colours.lua")

		if vim.fn.filereadable(theme_file) == 1 then
			local ok, c = pcall(dofile, theme_file)
			if not ok then
				vim.notify("Error loading iris theme: " .. tostring(c), vim.log.levels.ERROR)
				return
			end

			vim.opt.termguicolors = true
			vim.cmd("highlight clear")
			if vim.fn.exists("syntax_on") then
				vim.cmd("syntax reset")
			end
			vim.g.colors_name = "iris-wallpaper"

			-- Global Base UI (Solid Backgrounds)
			vim.api.nvim_set_hl(0, "Normal", { fg = c.fg, bg = c.bg })
			vim.api.nvim_set_hl(0, "NormalFloat", { fg = c.fg, bg = c.surface })
			vim.api.nvim_set_hl(0, "NormalNC", { fg = c.fg, bg = c.bg })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.accent, bg = c.surface })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = c.bg })
			vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = c.bg })
			vim.api.nvim_set_hl(0, "CursorLine", { bg = c.surface })

			-- Syntax Highlighting
			vim.api.nvim_set_hl(0, "Comment", { fg = c.comment, italic = true })
			vim.api.nvim_set_hl(0, "Keyword", { fg = c.keyword, bold = true })
			vim.api.nvim_set_hl(0, "String", { fg = c.string })
			vim.api.nvim_set_hl(0, "Function", { fg = c.func })
			vim.api.nvim_set_hl(0, "Type", { fg = c.type })
			vim.api.nvim_set_hl(0, "Constant", { fg = c.const })
			vim.api.nvim_set_hl(0, "Identifier", { fg = c.accent })

			-- Define custom LeetCode highlight groups matching Iris palette
			vim.api.nvim_set_hl(0, "LeetCodeSidebar", { fg = c.fg, bg = c.bg })
			vim.api.nvim_set_hl(0, "LeetCodeNormal", { fg = c.fg, bg = c.bg })

			-- Force LeetCode and Markdown buffers to adopt Iris colors and strip grey text overrides
			vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
				pattern = { "markdown", "leetcode.nvim" },
				callback = function(ev)
					vim.bo[ev.buf].syntax = "OFF"
					vim.opt_local.winhl = "Normal:Normal,NormalFloat:NormalFloat,SignColumn:Normal,EndOfBuffer:Normal"

					-- Apply a window-local highlight override to force background matching
					vim.wo.winhighlight = "Normal:Normal,NormalFloat:NormalFloat,EndOfBuffer:Normal"
				end,
			})

			-- Catch any dynamic LeetCode UI events to re-apply window highlights
			vim.api.nvim_create_autocmd("User", {
				pattern = "LeetCode*",
				callback = function()
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
						local buf = vim.api.nvim_win_get_buf(win)
						local ft = vim.bo[buf].filetype
						if ft == "markdown" or ft == "leetcode.nvim" then
							vim.wo[win].winhighlight = "Normal:Normal,NormalFloat:NormalFloat,EndOfBuffer:Normal"
						end
					end
				end,
			})
		else
			vim.cmd.colorscheme("default")
			vim.notify("Iris theme file missing at: " .. theme_file, vim.log.levels.WARN)
		end
	end,
}
