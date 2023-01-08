return {
  -- a bunch of treesitter queries
  { -- adapted from LazyVim
    "nvim-treesitter/nvim-treesitter-textobjects",
    init = function()
      require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
    end,
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    config = {
      useDefaultKeymaps = false,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
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
        },
        indent = {
          enable = true,
        },
        -- can be enabled with ":TSBufEnable incremental_selection"
        -- incremental_selection = {
        --   enable = true,
        --   keymaps = { -- default keymaps
        --     init_selection = "gnn",
        --     node_incremental = "grn",
        --     scope_incremental = "grc",
        --     node_decremental = "grm",
        --   },
        -- },
      }
    end,
  }
}
