-- custom options

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf = args.buf
    pcall(vim.treesitter.start, buf)

    -- Only use tree-sitter indentation when the language actually ships an
    -- indents query. Otherwise keep the filetype's own indent script (e.g.
    -- QML), which would be silently overridden by an empty indentexpr.
    local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype) or vim.bo[buf].filetype
    local ok, query = pcall(vim.treesitter.query.get, lang, 'indents')
    if ok and query then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

vim.opt.expandtab       = true  --convert tabs to spaces
vim.opt.shiftwidth      = 4     --how much spaces one tab/indentation is
vim.opt.tabstop         = 4
vim.opt.softtabstop     = 4

vim.opt.smarttab    = true
vim.opt.smartindent = true
vim.opt.autoindent  = true
vim.opt.breakindent = true

vim.opt.number          = true -- show line numbers
--vim.opt.relativenumber  = true -- show relative line numbers

vim.opt.cursorline = true -- highlight current line

vim.opt.undofile = true -- make undos persist between sessions

vim.opt.mouse = "a" -- enable mouse mode

vim.opt.showmode = false --dont show the current mode as it is already in the status line

vim.opt.ignorecase = true -- disable search being case sensitive by default
vim.opt.smartcase   = true -- auto switch to case sensitive

vim.opt.signcolumn = "yes" -- keep signcolumn on by default

vim.opt.splitright  = true -- make splits spawn in a logical ares
vim.opt.splitbelow  = true

vim.opt.scrolloff   = 5 -- min number of lines to keep above and below cursor

-- vim.opt.cmdheight   = 0 -- keep commandline closed until needed
