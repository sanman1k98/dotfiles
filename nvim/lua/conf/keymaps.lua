local map = require "util.map"

map.insert["kj"]("<esc>")

map.normal {
  ["<leader>;"] = ":",
  ["<leader>w"] = "<cmd>w<cr>",
  ["<leader>e"] = ":e ",
  ["<leader>lc"] = function()
    vim.opt_local.list = not vim.opt_local.list:get()
  end,
  ["<leader>lz"] = vim.cmd.Lazy,
}
