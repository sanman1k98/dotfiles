-- false if nvim was started with "--noplugin"
local cmd = vim.cmd
local au = require "utils.auto"



do -- main configuration
  -- require "events"
  require "options"
  require "keymaps"

  cmd.colorscheme "cat_mocha"
end


do -- automatically apply changes without restarting nvim
  au.user.config_changed(function(t)
    local file = t.file
    vim.pretty_print("User config file changed! ", file)
  end)
end


if vim.opt.loadplugins:get() then           -- false if "nvim --noplugin"
  local paq_loaded = pcall(require, "paq")
  if not paq_loaded then
    local bootstrap = require "utils.bootstrap"
    bootstrap.add_paq()   -- adds to packpath
  end
end
