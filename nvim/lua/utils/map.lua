local M = {}

function M.args(tbl)
  local iter = function(t)
    for mode, mappings in pairs(tbl) do
      for lhs, info in pairs(mappings) do
        local rhs = info[1]
        local opts = info.opts or {}
        opts.desc = info.desc
        opts.buffer = info.buffer
        coroutine.yield(mode, lhs, rhs, opts)
      end
    end
  end
  return coroutine.wrap(function() iter(tbl) end)
end

-- TODO: better error messages
function M.validate(tbl)
  for mode, mappings in pairs(tbl) do
    vim.validate {
      mode = { mode, function(x)
        return type(x) == "string" and #x <= 1
      end, "a mode short-name" },
    }
    for lhs, info in pairs(mappings) do
      local valid_lhs, lhs_msg = pcall(vim.validate, { lhs = { lhs, "s" } })
      if not valid_lhs then
        local m = string.format("invalid keymap in mode %q %s", mode, lhs_msg)
        error(m, 2)
      end
      local valid_info, info_msg = pcall(M.validate_info, info)
      if not valid_info then
        local m = string.format("`info` table for keymap %q in mode %q is invalid: %s", lhs, mode, info_msg)
        error(m, 2)
      end
    end
  end
end

-- TODO: better error messages
function M.validate_info(info)
  vim.validate {
    ["info"] = { info, "t" },
    ["info[1]"] = { info[1], {"s", "f"} },
    ["info.desc"] = { info.desc, "s", true },
    ["info.buffer"] = { info.buffer, "n", true },
    ["info.opts"] = { info.opts, "t", true },
  }
end

-- TODO: better error messages
function M.set(tbl)
  for mode, lhs, rhs, opts in M.args(tbl) do
    local validinfo, validationmsg = pcall(M.validate_info, tbl[mode][lhs])
    if not validinfo then
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
