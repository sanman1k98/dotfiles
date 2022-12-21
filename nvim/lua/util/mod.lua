local mod = {}

--- Get loaders for a module's submodules one name level deep.
---
--- Example package structure for modname "mod":
---   /mod/init.lua
---   /mod/sub1.lua
---   /mod/sub2.lua
---   /mod/sub3/init.lua
--- The submodules are mod.sub1, mod.sub2, and mod.sub3.
---
---@param modname string|nil: arg passed to require()
---@return table: list of loader functions
---@see vim._load_package()
function mod._load_submods(modname)
  local loaders = {}  -- list of compiled loaders
  local modpath = nil -- path to some Lua module
  local submods = nil -- directory containing some module's submodules
  if modname then -- get modpath using a modified 'vim._load_package()'
    local basename = modname:gsub("%.", "/")
    local patterns = {
      "lua/"..basename..".lua",
      "lua/"..basename.."/init.lua",
    }
    local found = vim.api.nvim__get_runtime(patterns, false, { is_lua = true })
    if #found == 0 then return nil end  -- return nil when given module is not found
    modpath = found[1]
  else  -- use the path of the caller for modpath
    modpath = debug.getinfo(2, "S").source:sub(2)
  end
  if vim.endswith(modpath, "init.lua") then
    submods = vim.fs.dirname(path)  -- module and submods are colocated in same dir
  else -- find a dir with same name as module in its parent dir
    local parentdir = vim.fs.dirname(modpath)
    local name = vim.fs.basename(modpath):sub(1, -5) -- basename without '.lua' ext
    for dir, t in vim.fs.dir(parentdir) do
      if t == "directory" and dir == name then
        submods = parentdir.."/"..dir
        break -- found match; exit loop
      end
    end
    if not submods then
      return {} -- no submods for module in this package; return empty table
    end
  end
  for submod, t1 in vim.fs.dir(submods) do  -- compile loaders for all submods
    if t1 == "file" then
      if not submod:sub(-4) == ".lua" then
        goto continue -- skip file if not Lua
      elseif submod == "init.lua" then
        goto continue -- skip file if parent module
      end
      local f, err = loadfile(submods.."/"..submod) -- compile loader
      if not f then error(err) end
      loaders[submod:sub(1, -5)] = f
    elseif t1 == "directory" then
      local subdir = submods.."/"..submod
      for file, t2 in vim.fs.dir(subdir) do -- search for an 'init.lua'
        if t2 == "file" and file == "init.lua" then
          local f, err = loadfile(subdir.."/"..file)
          if not f then error(err) end
          loaders[submod] = f
        end
      end
    end
    ::continue::  -- next iteration
  end
  return loaders
end

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

---@param file string|nil: path to a Lua file; defaults to calling module
---@return string: fully qualified modname
function mod.name(file)
  if not file then
    file = debug.getinfo(2, "S").source:sub(2)
  end
  local names = { vim.fs.basename(file):sub(1, -5) } -- remove '.lua' extension
  for parent in vim.fs.parents(file) do
    local dirname = vim.fs.basename(parent)
    if dirname == "lua" then break end
    table.insert(names, 1, dirname)  -- prepend parent dirname
  end
  if #names > 1 and names[#names] == "init" then
    table.remove(names)
  end
  return table.concat(names, ".")
end

--- Returns a module that will only be loaded when you do something with it.
---@return table: a lazy module
---@see noice.util.lazy
function mod.lazy(modname)
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

return mod
