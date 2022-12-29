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

---@private
local function _caller_modname()
  local fs = vim.fs
  local path = debug.getinfo(3, "S").source:sub(2)
  assert(vim.endswith(path, ".lua"), ("expected Lua file; got '%s'"):format(path))
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

--- Get a function that calls `require` on a module's submodules.
---@param modname string|nil: defaults to the calling module's name
---@return fun(submod: string): any
function M.submods(modname)
  modname = modname or _caller_modname()          -- use caller's modname if not given
  return (function(submod)                        -- takes a name of a submodule
    local fullname = modname.."."..submod         -- fully qualified name of submodule
    return require(fullname)                      -- require submodule
  end)
end

--- Returns a module that will only be loaded when you do something with it.
---@return table: a lazy module
---@see noice.util.lazy
function M.defer_require(modname)
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
