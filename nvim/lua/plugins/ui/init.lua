return {
  -- libs for other plugins
  "nvim-tree/nvim-web-devicons",
  "MunifTanjim/nui.nvim",

  -- notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = {
    },
  },

  -- UI
  {
    "folke/noice.nvim",
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

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = {
      options = {
        always_show_bufferline = false,
        -- mode = "tabs",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
          },
        },
      },
    },
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

  -- `alpha-nvim` spec and config
  require "plugins.ui.dashboard",

  -- various statusline specs and configs
  require("plugins.ui.statusline").lualine,
}
