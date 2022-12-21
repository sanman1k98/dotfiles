local Mode = {}

function Mode:__index(lhs)
  return (function(rhs, opts)
    vim.keymap.set(self._mode, lhs, rhs, opts)
  end)
end

function Mode:__call(mappings)
  for lhs, info in pairs(mappings) do
    if type(info) ~= "table" then
      vim.keymap.set(self._mode, lhs, info)
    else
      local rhs, opts = info[1], info
      opts[1] = nil
      vim.keymap.set(self._mode, lhs, rhs, opts)
    end
  end
end

local aliases = {
  normal      = "n",
  visual      = "v",
  op_pending  = "o",
  insert      = "i",
  command     = "c",
  terminal    = "t",
}

return setmetatable({}, {
  __index = function(_, k)
    if #k > 1 then
      k = aliases[k]
    end
    return setmetatable({ _mode = k }, Mode)
  end,
})
