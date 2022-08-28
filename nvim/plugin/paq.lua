local paq = require "paq"
local plugins = require "plugins"

local au = vim.api.nvim_create_autocmd
local augroups = require "augroups"



paq(plugins)


do -- automatically re-register plugins
  local path = vim.fn.stdpath("config") .. "/lua/plugins.lua"

  -- callback takes a single table as an argument
  local register_plugins = function(tb)
    -- the "file" key is the expanded value of <afile>
    local modname = vim.fs.basename(tb.file)
    package.loaded[modname] = nil
    plugins = require(modname)
    paq(plugins)
  end

  au("BufWritePost", {
    group = augroups.user_plugin_register,
    pattern = path,
    callback = register_plugins
  })
end
