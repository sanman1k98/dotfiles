local M = setmetatable({}, {  -- make this module load its submodules
  __index = function(self, k)
    local modname = "util."..k
    local submod = require(modname)
    rawset(self, k, submod)
    return submod
  end,
})

function M.notify(msg, lvl, opts)
  opts = opts or { title = "$MYVIMRC" }
  return vim.notify(msg, lvl, opts)
end

function M.err(msg)
  M.notify(msg, vim.log.levels.ERROR)
end

function M.warn(msg)
  M.notify(msg, vim.log.levels.WARN)
end

function M.info(msg)
  M.notify(msg, vim.log.levels.INFO)
end

function M.is_headless()
  return #vim.api.nvim_list_uis() == 0
end

--- Returns a module that will only be loaded when you do something with it.
---@return table: a lazy module
---@see noice.util.lazy
function M.require(modname)
  local m = nil
  local load = function()
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
      __index = function(_, k) return load()[k] end,
      __newindex = function(_, k, v) load()[k] = v end,
      __call = function(_, ...) return load()(...) end,
    })
  end
end

return M
