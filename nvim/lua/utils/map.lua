local map = {}

do
  map.modes = {
    "",
    "n",
    "v",
    "s",
    "x",
    "o",
    "!",
    "i",
    "l",
    "c",
    "t",
  }

  local mt = {}

  function mt:__call()
    local iter = function()
      for _, m in ipairs(map.modes) do coroutine.yield(m) end
    end
    return coroutine.wrap(function() iter() end)
  end

  setmetatable(map.modes, mt)
end

function map.iter(tbl)
  local iter = function(t)
    -- we will assume the whole table is a list if the first element exists
    local list = t[1]
    if list then
      if type(list) == "table" then
        for _, maparg in ipairs(t) do
          coroutine.yield(maparg.mode, maparg.lhs, maparg)
        end
        return
      elseif type(list) == "string" then
        for _, mode in ipairs(t) do
          coroutine.yield(mode)
        end
        return
      else error("List of unsupported type", 2) end
    else                                -- assume table with mode short-names as field names
      local _, v = next(t)
      -- we will assume whether all modes contain lists by only checking the first one
      local lhs_list = v and type(v) == "table" and v[1] and type(v[1]) == "string"
      for mode, mappings in pairs(t) do
        if lhs_list then                -- assume all fields contains a list of lhs
          for _, lhs in ipairs(mappings) do
            coroutine.yield(mode, lhs)
          end
          return
        else
          for lhs, info in pairs(mappings) do
            coroutine.yield(mode, lhs, info)
          end
          return
        end
      end
    end
  end
  return coroutine.wrap(function() iter(tbl) end)
end

function map.args(tbl)
  local iter = function(t)
    for mode, lhs, info in map.iter(t) do
      local rhs = info[1]
      local opts = info.opts or {}
      opts.desc, opts.buffer = info.desc, info.buffer
      coroutine.yield(mode, lhs, rhs, opts)
    end
  end
  return coroutine.wrap(function() iter(tbl) end)
end

function map.get(tbl, buf)
end

-- TODO: better error messages
function map.set(tbl)
  for mode, lhs, rhs, opts in map.args(tbl) do
    if not opts.desc then
      local m = string.format("No description supplied for keymap %q in mode %q.", lhs, mode)
      vim.notify(m, vim.log.levels.WARN)
    end
    local set, errmsg = pcall(vim.keymap.set, mode, lhs, rhs, opts)
    if not set then
      local m = string.format("Error setting keymap %q in mode %q:\n%s", lhs, mode, errmsg)
      vim.notify(m, vim.log.levels.ERROR)
      goto continue
    end
    ::continue::
  end
end

function map.del(tbl)
end

return map
