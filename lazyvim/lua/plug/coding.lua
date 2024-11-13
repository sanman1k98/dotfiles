local map = require("util.map")

return {
  -- split/join
  {
    "Wansmer/treesj",
    opts = function ()
      local lang_utils = require("treesj.langs.utils")
      local html = require("treesj.langs.html")
      local ts = require("treesj.langs.typescript")

      local langs = {
        astro = lang_utils.merge_preset(html, ts)
      }

      return {
        use_default_keymaps = false,
        max_join_length = 150,
        langs = langs,
      }
    end,
    keys = map.lazykeys {
      prefix = "<leader>j",
      label = "split/join",
      { "j", function() require("treesj").toggle() end, desc = "Toggle split" },
    },
  },

  -- AI-powered coding
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      "stevearc/dressing.nvim", -- Optional: Improves `vim.ui.select`
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "codecompanion" }, -- Optional: For prettier markdown rendering
      },
    },
    config = true,
  },
}
