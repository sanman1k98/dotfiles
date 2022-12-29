local util = require "util"
local map = util.map

map.insert {
  ["kj"] = { "<esc>", "leave insert mode" },
}

map.normal {
  ["<leader>;"] = { ":", "enter command-line mode" },
  ["<leader>w"] = { "<cmd>w<cr>", "Write file" },
  ["<leader>e"] = { ":e ", "Edit file" },
  ["<leader>lc"] = { function()
    vim.opt_local.list = not vim.opt_local.list:get()
  end, "toggle List Chars" },
  ["<leader>lz"] = { vim.cmd.Lazy, "show Lazy window" },
}

map.visual {
  ["<"] = { "<gv" },
  [">"] = { ">gv" },
}

local keymaps = util.mod.submods()  -- returns a function

keymaps "neo-tree"
keymaps "telescope"
keymaps "which-key"

return keymaps
