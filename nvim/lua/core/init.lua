local util = require "util"
local this = util.mod.name()

return function(submod)
  local modname = ("%s.%s"):format(this, submod)
  local mod = require(modname)
  if type(mod) == "function" then
    return mod()
  end
  return mod
end
