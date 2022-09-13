local M = {}

function M.args(tbl)
  local iter = function(t)
    for mode, mappings in pairs(tbl) do
      for lhs, def in pairs(mappings) do
        local desc, rhs, opts = def[1], def[2], def[3]
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
end

function M.del(tbl)
end

return M
