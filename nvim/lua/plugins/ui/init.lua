local map = require "util.map"

return {
  -- libs for other plugins
  "nvim-tree/nvim-web-devicons",
  "MunifTanjim/nui.nvim",

  -- notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {},
    keys = map.lazykeys({
      name = "notifications",
      prefix = "<leader>n",
      d = {
        function()
          require("notify").dismiss({
            pending = true,
            silent = true,
          })
        end,
        desc = "dismiss all",
      }
    }),
  },

  -- UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
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
        long_message_to_split = true,
        lsp_doc_border = false,
      },
    },
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
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

  -- tabline
  {
    "nanozuki/tabby.nvim",
    event = "VeryLazy",
    config = function()
      require("tabby.tabline").use_preset("active_wins_at_tail", {
        buf_name = {
          mode = "unique",
        },
      })
    end,
  },

  -- screensaver
  {
    "folke/drop.nvim",
    enabled = false,
    event = "VimEnter",
    opts = {
      theme = "stars",
    },
  },

  -- `alpha-nvim` spec and config
  require "plugins.ui.dashboard",

  -- various statusline specs and configs
  require("plugins.ui.statusline").lualine,
}
