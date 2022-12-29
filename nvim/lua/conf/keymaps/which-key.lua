local util = require "util"
local map = util.map

map.normal {
  ["<leader>wk"] = { vim.cmd.WhichKey, "show all keymappings" },
}
