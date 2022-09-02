-- false if nvim was started with "--noplugin"
local cmd = vim.cmd
local au = require "utils.au"
local load_plugins = vim.opt.loadplugins:get()



do -- main configuration
  require "augroups"
  require "options"
  require "keymaps"
  -- source matching file in "~/.config/nvim/colors/"
  cmd.colorscheme "catppuccin"
end


do -- automatically apply changes without restarting nvim
  au.user.config_changed(function(t)
    local file = t.file
    vim.pretty_print("User config file changed! ", file)
  end)
end


do -- load plugin manager
  local paq_loaded = pcall(require, "paq")
  -- install if nvim is going to load plugins
  if load_plugins and not paq_loaded then
    local bootstrap = require "utils.bootstrap"
    bootstrap.add_paq()   -- adds to packpath
  end
end
