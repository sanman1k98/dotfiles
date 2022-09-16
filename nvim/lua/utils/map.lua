local M = {}

function M.args(tbl)
  local iter = function(t)
    for mode, mappings in pairs(tbl) do
      for lhs, info in pairs(mappings) do
        local desc, rhs, opts = info[1], info[2], info[3]
        opts = opts or {}
        opts.desc = desc
        coroutine.yield(mode, lhs, rhs, opts)
      end
    end
  end
  return coroutine.wrap(function() iter(tbl) end)
end

function M.validate(tbl)
end

function M.set(tbl)
  for mode, lhs, rhs, opts in M.args(tbl) do
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

function M.del(tbl)
end

return M
