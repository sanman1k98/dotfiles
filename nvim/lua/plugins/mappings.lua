vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function mappings()
  local map = require "util.map"

  map.set {
    mode = "i",
    ["kj"] = { "<esc>", desc = "ESC" },
    ["<c-f>"] = { "<right>", desc = "->" },
    ["<c-b>"] = { "<left>", desc = "<-" },
  }

  map.set {
    prefix = "<leader>",
    [";"] = { ":", "command-line" },
    w = { vim.cmd.write, "write file" },
    l = { vim.cmd.Lazy, "Lazy"},
    t = {
      name = "toggles",
      ["lc"] = { desc = "list chars",
        function() vim.opt_local.list = not vim.opt_local.list:get() end,
      },
      ["nc"] = { desc = "number column",
        function()
          local set = vim.wo.number
          vim.wo.number = not set
          vim.wo.relativenumber = not set
        end,
      },
    },
    ["."] = {
      name = "config",
      ["p"] = { desc = "Profile startup with Lazy",
        function() require("lazy.view.commands").commands["profile"]() end,
      }
    }
  }
end

return {
  "folke/which-key.nvim",
  init = mappings,
  cmd = "WhichKey",
  event = "VeryLazy",
  opts = {
    plugins = {},
    operators = {},
    key_labels = {
      ["<leader>"] = "SPACE",
      ["<CR>"] = "RET",
      ["<tab>"] = "TAB",
    },
    show_help = false,
    show_keys = true,
  },
  config = function(_, opts)
    vim.o.timeoutlen = 300
    require("which-key").setup(opts)
    require("util.map").loadall()
  end,
}
