local util = require "util"
local auto = util.mod.lazy "luauto" -- returns a lazy module

util.globals()

util.lazy.setup "plugins"

require "core.autocmds"
require "core.options"

auto.cmd.User.VeryLazy(function()
  require "core.keymaps"
end)

vim.cmd.colorscheme "catppuccin"
