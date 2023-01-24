vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function mappings()
  local util = require "util"
  local toggle = util.toggle

  util.map.set ({
    {
      mode = "i",
      ["kj"] = { "<esc>", desc = "ESC" },
      ["<c-f>"] = { "<right>", desc = "->" },
      ["<c-b>"] = { "<left>", desc = "<-" },
    },
    {
      -- better up/down for wrapped lines
      j = { "v:count == 0 ? 'gj' : 'j'", silent = true, expr = true },
      k = { "v:count == 0 ? 'gk' : 'k'", silent = true, expr = true },
      -- windows
      ["<a-up>"]    = { "<c-w>k", desc = "left window" },
      ["<a-down>"]  = { "<c-w>j", desc = "down window" },
      ["<a-left>"]  = { "<c-w>h", desc = "up window" },
      ["<a-right>"] = { "<c-w>l", desc = "right window" },
      ["<s-up>"]    = { "<cmd>resize +2<cr>", desc = "window height +" },
      ["<s-down>"]  = { "<cmd>resize -2<cr>", desc = "window height -" },
      ["<s-left>"]  = { "<cmd>vertical resize -2<cr>", desc = "window width -" },
      ["<s-right>"] = { "<cmd>vertical resize +2<cr>", desc = "window width +" },
      -- Neovim (specifically a dependency libtermkey) does not recognize the super modifier.
      -- ["<D-S>"] = { vim.cmd.write, desc = "write" },
    },
    {
      name = "shortcuts",
      prefix = "<leader>",
      [";"] = { ":", desc = "command-line", mode = { "n", "v" } },
      w = { vim.cmd.write, "write file" },
      l = { vim.cmd.Lazy, "Lazy"},
      ["<tab>"] = {
        name = "tabs",
        q = { "<cmd>tabclose<cr>", desc = "close" },
        -- windows
      },
      h = {
        name = "help",
        i = { "<cmd>tab help index<cr>", desc = "index in new tab" },
      },
      t = {
        name = "toggles",
        t = { util.colors.switch, desc = "light/dark theme" },
        w = { desc = "show whitespace",
          function() toggle "list" end,
        },
        l = { desc = "cursorline",
          function() toggle "cursorline" end,
        },
        n = { desc = "number column",
          function()
            toggle {
              "number",
              "relativenumber",
            }
          end,
        },
        c = { desc = "conceal level",
          function()
            toggle {
              conceallevel = { 0, 3 }
            }
          end
        },
      },
      ["."] = {
        name = "config",
        p = { desc = "Profile startup with Lazy",
          function() require("lazy.view.commands").commands["profile"]() end,
        },
      },
      b = {
        name = "buffers",
        l = { "<cmd>buffers<cr>", desc = "list buffers" },
      },
      q = {
        name = "quit",
        q = { "<cmd>quitall<cr>", desc = "quit all" },
      },
    },
  })
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
