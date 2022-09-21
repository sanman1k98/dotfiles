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
    local validinfo, validationmsg = pcall(M.validate_info, tbl[mode][lhs])
    if not validinfo then
      assert(not validinfo, "validation logic is faulty; should error when a description is not supplied")
      local m = string.format("`info` table for mapping %q in mode %q is invalid: %s", lhs, mode, validationmsg)
      vim.notify(m, vim.log.levels.ERROR)
      goto continue
    end
    local set, errmsg = pcall(vim.keymap.set, mode, lhs, rhs, opts)
    if not set then
      local m = string.format("error setting keymap %q in mode %q: %s", lhs, mode, errmsg)
      vim.notify(m, vim.log.levels.ERROR)
      goto continue
    end
    ::continue::
  end
end

function M.del(tbl)
end

return M
