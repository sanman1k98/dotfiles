local ts = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  build = ":TSUpdate",
  event = "BufReadPost",
}

ts.config = function()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "lua",
      "vim",
      "bash",
      "regex",
      "markdown",
      "markdown_inline",
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    -- can be enabled with ":TSBufEnable incremental_selection"
    incremental_selection = {
      enable = true,
      keymaps = { -- default keymaps
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  }
  vim.g.ts_highlight_lua = true
  -- setup context after
  require("treesitter-context").setup()
end

return ts
