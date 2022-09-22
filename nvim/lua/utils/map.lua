local M = {}

function M.iter(tbl)
  local iter = function(t)
    for mode, mappings in pairs(tbl) do
      for lhs, info in pairs(mappings) do
        coroutine.yield(mode, lhs, info)
      end
    end
  end
  return coroutine.wrap(function() iter(tbl) end)
end

function M.args(tbl)
  local iter = function(t)
    for mode, lhs, info in M.iter(tbl) do
      local rhs = info[1]
      local opts = info.opts or {}
      opts.desc, opts.buffer = info.desc, info.buffer
      coroutine.yield(mode, lhs, rhs, opts)
    end
  end
  return coroutine.wrap(function() iter(tbl) end)
end

-- TODO: better error messages
function M.set(tbl)
  for mode, lhs, rhs, opts in M.args(tbl) do
    if not opts.desc then
      local m = string.format("no description supplied")
      vim.notify(m, vim.log.levels.WARN)
    end
    local set, errmsg = pcall(vim.keymap.set, mode, lhs, rhs, opts)
    if not set then
      local m = string.format("error setting keymap %q in mode %q:\n%s", lhs, mode, errmsg)
      vim.notify(m, vim.log.levels.ERROR)
      goto continue
    end
    ::continue::
  end
end

function M.del(tbl)
end

return M
