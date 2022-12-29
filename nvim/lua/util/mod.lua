local mod = {}

function mod.path(modname)
  if not modname then
    return debug.getinfo(2, "S").source:sub(2)
  end
  local basename = modname:gsub("%.", "/")
  local patterns = {
    "lua/"..basename..".lua",
    "lua/"..basename.."/init.lua",
  }
  local found = vim.api.nvim__get_runtime(patterns, false, { is_lua = true })
  if #found == 0 then
    return nil
  else
    return found[1]
  end
end

---@param path string|nil: path to a Lua file; defaults to calling module
---@return string: fully qualified modname
function mod.name(path)
  path = path or debug.getinfo(2, "S").source:sub(2)
  assert(vim.endswith(path, ".lua"), ("expected Lua file; got '%s'"):format(path))
  local fs = vim.fs
  local names = { fs.basename(path):sub(1, -5) }   -- initialize list of names
  for parent in fs.parents(path) do                -- traverse through module heirarchy
    local dirname = fs.basename(parent)           -- get directory name
    if dirname == "lua" then break end            -- check if we're at the package root
    table.insert(names, 1, dirname)               -- prepend name to list
  end
  if #names > 1 and names[#names] == "init" then  -- check if last item is 'init'
    table.remove(names)                           -- pop last item
  end
  return table.concat(names, ".")                 -- the calling module's name
end

--- Returns a module that will only be loaded when you do something with it.
---@return table: a lazy module
---@see noice.util.lazy
function mod.defer(modname)
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

function mod.submods(modname)
  modname = modname or mod.name(debug.getinfo(2, "S").source:sub(2))
  return (function(submod)
    local fullname = modname.."."..submod
    return require(fullname)
  end)
end

return mod
