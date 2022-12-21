local configure = require "core"
local util = require "util"
local auto = util.require "luauto" -- returns a lazy module

configure "globals"
configure "options"

util.lazy.setup "plugins"

auto.cmd.User.VeryLazy(function()
  configure "autocmds"
  configure "keymaps"
  return true
end)

vim.cmd.colorscheme "catppuccin"
