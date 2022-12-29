local conf = require "conf"
local util = require "util"
local auto = util.mod.defer "luauto" -- returns a lazy module

conf "globals"
conf "options"

util.lazy.setup "plugins"

auto.cmd.User.VeryLazy(function()
  conf "autocmds"
  conf "keymaps"
  return true
end)

vim.cmd.colorscheme "catppuccin"
