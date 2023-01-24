return {
  -- a bunch of treesitter queries
  { -- adapted from LazyVim
    "nvim-treesitter/nvim-treesitter-textobjects",
    init = function(plugin)
      require("lazy.core.loader").disable_rtp_plugin(plugin.name)
    end,
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    config = {
      useDefaultKeymaps = false,
    },
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
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
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  }
}
