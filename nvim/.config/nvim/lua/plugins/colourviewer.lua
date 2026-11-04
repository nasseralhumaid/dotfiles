return {
	"Godswill-255/colorviewer.nvim",
	config = function()
		local colorviewer = require("colorviewer")
		colorviewer.setup({
			symbol = "■",
		})

		-- The plugin only auto-refreshes a hard-coded list of frontend
		-- filenames (*.css, *.js, *.html, ...), so QML (and Lua, Markdown,
		-- config files, ...) never get swatches. It also matches colour names
		-- as plain substrings, which makes "Rectangle" show a tan swatch and
		-- "steelblue" show two swatches (steelblue + blue).
		--
		-- Replace its scanner with one that:
		--   * matches whole words only (case-insensitive, via Neovim's X11
		--     colour table, which includes all CSS/QML colour names)
		--   * understands #RGB, #RRGGBB and QML's #AARRGGBB
		local ns = vim.api.nvim_create_namespace("colorviewer")
		local name_cache = {}

		-- X11 also has "background"/"foreground" colours, but in CSS/QML they
		-- are property names (e.g. a Control's `background:`), not colours.
		local ignored_names = { background = true, foreground = true }

		local function hex_for_name(word)
			local key = word:lower()
			if ignored_names[key] then
				return nil
			end
			local cached = name_cache[key]
			if cached ~= nil then
				return cached ~= false and cached or nil
			end
			local color = vim.api.nvim_get_color_by_name(word)
			if color and color >= 0 then
				local hex = string.format("#%06x", color)
				name_cache[key] = hex
				return hex
			end
			name_cache[key] = false
			return nil
		end

		local function normalize_hex(digits)
			if #digits == 3 then
				digits = digits:sub(1, 1):rep(2)
					.. digits:sub(2, 2):rep(2)
					.. digits:sub(3, 3):rep(2)
			elseif #digits == 8 then
				-- QML uses #AARRGGBB; previews ignore alpha.
				digits = digits:sub(3)
			end
			return "#" .. digits
		end

		local function add_swatch(bufnr, row, col, hex)
			local group = "ColorViewer_" .. hex:gsub("#", "")
			vim.api.nvim_set_hl(0, group, { fg = hex })
			vim.api.nvim_buf_set_extmark(bufnr, ns, row, col, {
				virt_text = { { colorviewer.config.symbol, group } },
				virt_text_pos = "inline",
			})
		end

		local function refresh(bufnr)
			bufnr = bufnr or vim.api.nvim_get_current_buf()
			if not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end

			vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

			for i, line in ipairs(lines) do
				local row = i - 1

				-- Hex colours: #RGB, #RRGGBB, #AARRGGBB
				local init = 1
				while true do
					local start, finish = line:find("#%x+", init)
					if not start then
						break
					end
					local digits = line:sub(start + 1, finish)
					if #digits == 3 or #digits == 6 or #digits == 8 then
						add_swatch(bufnr, row, start - 1, normalize_hex(digits))
					end
					init = finish + 1
				end

				-- Named colours: whole identifiers only.
				for start, word in line:gmatch("()([%a_][%w_]*)") do
					if line:sub(start - 1, start - 1) ~= "#" then
						local hex = hex_for_name(word)
						if hex then
							add_swatch(bufnr, row, start - 1, hex)
						end
					end
				end
			end
		end

		colorviewer.show_color_boxes = refresh

		local filetypes = {
			"qml",
			"css", "scss", "less", "stylus",
			"html", "javascript", "javascriptreact",
			"typescript", "typescriptreact", "vue", "svelte",
			"lua", "vim", "markdown", "json", "jsonc",
			"yaml", "toml", "python", "sh", "bash", "conf",
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "BufWritePost" }, {
			callback = function(args)
				if vim.tbl_contains(filetypes, vim.bo[args.buf].filetype) then
					refresh(args.buf)
				end
			end,
		})
	end,
}
