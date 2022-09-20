local M = {}

function M.args(tbl)
  local iter = function(t)
    for mode, mappings in pairs(tbl) do
      for lhs, info in pairs(mappings) do
        local desc, rhs = info.desc, info[1]
        local opts = info.opts or {}
        opts.desc = desc
        coroutine.yield(mode, lhs, rhs, opts)
      end
    end
  end
  return coroutine.wrap(function() iter(tbl) end)
end

function M.validate(tbl)
end

function M.validate_info(info)
  vim.validate {
    ["info.desc"] = { info.desc, function(x)
      return type(x) == "string"
    end, "a description of the mapping" },
    ["info[1]"] = { info[1], function(x)
      return type(x) == "string" or type(x) == "function"
    end, "a string or a Lua function for the rhs of the mapping" },
    ["info.opts"] = { info.opts, function(x)
      return type(x) == "table" or x == nil
    end, "an optional \"opts\" table to pass to `vim.keymap.set`"}
  }
end

function M.set(tbl)
  for mode, lhs, rhs, opts in M.args(tbl) do
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

function M.del(tbl)
end

return M
