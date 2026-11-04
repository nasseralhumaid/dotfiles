vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })

vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Show LSP Diagnostics in Floating Window" })

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format Current File" })

vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
