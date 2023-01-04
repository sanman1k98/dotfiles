local load = {}

--- Returns a module that will only be loaded when you do something with it.
---@return table: a lazy module
---@see noice.util.lazy
function load.mod(modname)
  local m = nil
  local loader = function()
    if not m then
      m = require(modname)
      package.loaded[modname] = m
    end
    return m
  end
  if type(package.loaded[modname]) == "table" then
    return package.loaded[modname]
  else
    return setmetatable({}, {
      __index = function(_, k) return loader()[k] end,
      __call = function(_, ...) return loader()(...) end,
    })
  end
end

function load.submods(modname)
  local fmt = function(k) return ("%s.%s"):format(modname, k) end
  return setmetatable({}, {
    __index = function(mod, k)
      local subname = fmt(k)
      local submod = package.loaded[subname]
      if submod then
        rawset(mod, subname, submod)
        return submod
      end
      return load.mod(subname)
    end,
    __call = function(mod, k)
      local subname = fmt(k)
      local submod = require(subname)
      rawset(mod, subname, submod)
      return submod
    end,
  })
end

return load
