local paq = require "paq"
local plugins = require "plugins"

paq(plugins)


do -- automatically reload plugins
  local au = require "utils.au"
  au.user.plugins_changed(function()
    package.loaded.plugins = nil
    plugins = require "plugins"
    paq(plugins)
  end)
end
