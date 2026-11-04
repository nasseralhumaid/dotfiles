-- lazy.nvim
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  dependencies = {
      -- Install fzf-lua as the high-performance fuzzy finder backend
      "ibhagwan/fzf-lua",
  },
  opts = {
    input = {
        enabled = true,
    },
    picker = {
      enabled = true,
      ui_select = true,
    }
  }
}
