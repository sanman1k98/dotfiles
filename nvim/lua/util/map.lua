local notify = require "util.notify"
local M = {}
local Mode, ModeIndex = {}, {}

local MYALIASES = {
  normal      = "n",
  visual      = "v",  -- actually visual and select mode
  select      = "x",
  op_pending  = "o",
  insert      = "i",
  command     = "c",
  terminal    = "t",
}

-- false if not actual mapargs
local OPTKEYS = {
  -- [1]               = false,
  -- [2]               = false,
  prefix            = false,
  name              = false,
  cond              = false,
  mode              = false,
  buffer            = true,
  desc              = true,
  expr              = true,
  nowait            = true,
  unique            = true,
  -- noremap           = true,
  -- replace_keycodes  = true,
}

local function optkey(k)
  return OPTKEYS[k] ~= nil
end

local function merge(...)
  return vim.tbl_extend("force", ...)
end

-- local function maparg(k)
--   return OPTKEYS[k]
-- end

--- Get the opts from a group of mappings
---@param mappings table
local function getopts(mappings)
  local opts = {}
  for k, v in pairs(mappings) do
    if optkey(k) then opts[k] = v end
  end
  if vim.is_callable(opts.cond) then
    opts.cond = opts.cond()
  end
  return opts
end

--- Traverse a group of mappings structured as a prefix-tree and generate lhs,
--- rhs, and opts for each valid mapping.
---@param mappings table: prefix-tree node
---@param opts table|nil: overrides opts found in mappings
local function parse(mappings, opts)
  opts = merge(getopts(mappings), opts or {})
  assert(opts.mode)
  if opts.cond ~= nil and not opts.cond then
    assert(not vim.is_callable(opts.cond))
    return
  end
  if not opts.prefix then -- we're at the root of the group
    opts.prefix = opts.prefix or ""
  end
  local co = coroutine
  return co.wrap(function()
    local subgroups = {}  -- subnodes/children to parse
    for k, info in pairs(mappings) do -- iter through this node
      local lhs = opts.prefix..k
      if k == "name" then -- wk group name
        co.yield(lhs, nil, merge(opts, { name = info }))
      elseif type(info) == "string" or vim.is_callable(info) then -- rhs value for mapping
        co.yield(lhs, info, opts)
      elseif info == false then -- del keymap
        co.yield(lhs, false, opts)
      elseif not optkey(k) and type(info) == "table" then -- 
        if info[1] then -- has rhs value for mapping
          co.yield(lhs, info[1], merge(opts, info))
        else  -- subnode to parse
          subgroups[lhs] = info
        end
      end
    end
    for prefix, subgroup in pairs(subgroups) do -- go through children
      opts.prefix = prefix
      for lhs, rhs, o in parse(subgroup, opts) do -- recurse (maybe not technically?)
        co.yield(lhs, rhs, o)
      end
    end
  end)
end

M.mode = {}

for alias, shortname in pairs(MYALIASES) do
  M.mode[alias] = function(mappings, opts)
    opts = opts or {}
    opts.mode = shortname
    local parsed = {}
    for lhs, rhs, args in parse(mappings, opts) do
      parsed[lhs] = { rhs, args }
    end
    d(parsed)
  end
end

local function use_vim(mappings, opts)
  local ret = {}
  local mode, prefix = opts.mode, opts.prefix or ""
  opts.mode, opts.prefix = nil, nil
  for lhs, info in pairs(mappings) do
    lhs = prefix..lhs
    local is_rhs = type(info) == "string" or vim.is_callable(info)
    if is_rhs then
      vim.keymap.set(mode, lhs, info, opts)
    elseif type(info) == "table" then
      local rhs, desc = info[1], info[2] or info.desc
      info[1], info[2] = nil, nil
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, info, { desc = desc }))
    elseif info == false then
      vim.keymap.del(mode, lhs, opts)
    end
    if info ~= false then
      table.insert(ret, { lhs, mode = mode })
    end
  end
  return ret
end

function Mode:__call(mappings, opts)
  opts = opts or {}
  opts.mode = self._mode
  use_vim(mappings, opts)
end

for alias, shortname in pairs(MYALIASES) do
  M[alias] = setmetatable({ _mode = shortname }, Mode)
end

return M
