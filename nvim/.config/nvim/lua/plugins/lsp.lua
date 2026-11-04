return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		-- Buffer-local keymaps and UI features that depend on the attached client.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
				map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
				map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				if
					client
					and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
				then
					local highlight_group = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
						callback = function(detach_event)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = detach_event.buf })
						end,
					})
				end

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					map("<leader>th", function()
						local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
						vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					return diagnostic.message
				end,
			},
		})

		-- clangd needs `--query-driver` so it can ask the embedded GCC toolchain
		-- for target architecture and system includes. Only pass it for PlatformIO
		-- projects (detected by platformio.ini), leaving regular C/C++ projects
		-- with the default clangd setup.
		local pio_query_driver = table.concat({
			vim.env.HOME .. "/.platformio/packages/toolchain-*/bin/*",
			"/usr/bin/*",
		}, ",")

		-- Servers listed here are installed by Mason and configured with vim.lsp.config.
		local servers = {
			bashls = {},
			marksman = {},
			clangd = {
				cmd = function(dispatchers, config)
					local cmd = { "clangd" }
					local root = config.root_dir
					if root and vim.uv.fs_stat(root .. "/platformio.ini") then
						table.insert(cmd, "--query-driver=" .. pio_query_driver)
					end
					return vim.lsp.rpc.start(cmd, dispatchers)
				end,
				-- Prefer platformio.ini, then fall back to the usual C/C++ markers.
				root_markers = {
					"platformio.ini",
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					".git",
				},
				filetypes = { "c", "c.doxygen", "cpp", "cpp.doxygen", "objc", "objcpp", "cuda" },
			},
			lua_ls = {},
			qmlls = {
				cmd = { "qmlls", "-I", "/usr/lib/qt6/qml" },
				on_attach = function(client)
					-- qmlls advertises delta semantic tokens, but its delta edits are
					-- corrupt and crash Neovim's semantic_tokens.lua while editing QML.
					-- Force full-token requests to avoid the broken delta path.
					local provider = client.server_capabilities.semanticTokensProvider
					if provider and type(provider.full) == "table" then
						provider.full.delta = false
					end
				end,
			},
		}

		for name, server in pairs(servers) do
			vim.lsp.config(name, server)
		end

		local ensure_installed = vim.tbl_keys(servers)
		vim.list_extend(ensure_installed, { "stylua", "clang-format" })
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup()
	end,
}
