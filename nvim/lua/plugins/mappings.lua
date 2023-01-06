vim.o.timeoutlen = 300
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function mappings()
  local map = require "util.map"

  map.insert {
    ["kj"] = "<esc>",
    ["<c-f>"] = "<right>",
    ["<c-b>"] = "<left>",
  }

  map.normal {
    ["<leader>"] = {
      [";"] = { ":", "enter command-line" },
      w = { vim.cmd.write, "write file" },
      l = { vim.cmd.Lazy, "lazy.nvim"},
      f = {
        name = "fuzzy",
        ["<cr>"] = { vim.cmd.Telescope, "Telescope builtin" },
        [";"] = { function() require("telescope.builtin").commands() end, "commands" },
        f = { function() require("telescope.builtin").find_files() end, "find files" },
        h = { function() require("telescope.builtin").help_tags() end, "search help tags" },
        b = { function() require("telescope.builtin").buffers() end, "open buffers" },
        r = { function() require("telescope.builtin").reloader() end, "reload Lua modules" },
        o = { function() require("telescope.builtin").vim_options() end, "search Vim options" },
        k = { function() require("telescope.builtin").keymaps() end, "keymaps" },
      },
      t = {
        name = "toggles",
        ["lc"] = { desc = "list chars",
          function() vim.opt_local.list = not vim.opt_local.list:get() end,
        },
        ["e"] = { desc = "file explorer",
          "<cmd>Neotree toggle filesystem<cr>"
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
  }
end

return {
  "folke/which-key.nvim",
  init = mappings,
  cmd = "WhichKey",
  event = "VeryLazy",
  config = function()
    local map = require "util.map"
    map.wk = require "which-key"
    map.wk.setup {
      plugins = {},
      key_labels = {
        ["<leader>"] = "SPACE",
        ["<cr>"] = "RETURN",
        ["<tab>"] = "TAB",
      },
      show_help = false,
      show_keys = true,
    }
    map.defer = false
    map.dequeue_all()
  end,
}
