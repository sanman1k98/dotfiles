return {
  -- icons
  "nvim-tree/nvim-web-devicons",

  -- UI
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    config = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        lsp_doc_border = false,
      },
    },
  },

  -- statusline
  {
    "feline-nvim/feline.nvim",
    event = "VeryLazy",
    config = require "plugins.ui.feline",
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
  },

  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = require "plugins.ui.alpha",
  },

  -- screensaver
  {
    "folke/drop.nvim",
    enabled = false,
    event = "VimEnter",
    config = {
      theme = "stars",
    },
  },

}

