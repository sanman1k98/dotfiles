-- false if nvim was started with "--noplugin"
local load_plugins = vim.opt.loadplugins:get()
local cmd = vim.cmd
local au = vim.api.nvim_create_autocmd
-- create augroups and return a table containing their names and IDs
local augroups = require "augroups"



do -- main configuration
  require "options"
  require "keymaps"
  -- source matching file in "~/.config/nvim/colors/"
  cmd.colorscheme "catppuccin"
end


do -- automatically apply changes without restarting nvim
  local lua_dir = vim.fn.stdpath("config") .. "/lua"
  local paths = {
    lua_dir .. "/keymaps.lua",
    lua_dir .. "/options.lua",
  }
  au("BufWritePost", {
    group = augroups.user_config_reloader,
    pattern = paths,
    callback = function(tb)
      local file_path = tb.match
      cmd.source(file_path)
    end
  })
end


do -- load plugin manager
  local paq_loaded = pcall(require, "paq")
  -- install if nvim is going to load plugins
  if load_plugins and not paq_loaded then
    local bootstrap = require "utils.bootstrap"
    bootstrap.add_paq()   -- adds to packpath
  end
end
