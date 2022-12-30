local map = {}
local Mode = {}

local function merge(...)
  return vim.tbl_extend("force", ...)
end

local function use_vim(mappings, opts)
  local set = vim.keymap.set
  local mode, prefix = opts.mode, opts.prefix or ""
  opts.mode, opts.prefix = nil, nil
  for lhs, info in pairs(mappings) do
    lhs = prefix..lhs
    if type(info) == "table" then
      local rhs, desc = info[1], info[2] or info.desc
      info[1], info[2] = nil, nil
      set(mode, lhs, rhs, merge(opts, info, { desc = desc }))
    else
      set(mode, lhs, info, opts)
    end
  end
end

function Mode:__call(mappings, opts)
  opts = opts or {}
  opts.mode = self._mode
  use_vim(mappings, opts)
end

local aliases = {
  normal      = "n",
  visual      = "v",  -- actually visual and select mode
  op_pending  = "o",
  insert      = "i",
  command     = "c",
  terminal    = "t",
}

return setmetatable(map, {
  __index = function(_, k)
    if #k > 1 then
      k = aliases[k]
    end
    local shortname = k
    return setmetatable({ _mode = shortname }, Mode)
  end,
})
