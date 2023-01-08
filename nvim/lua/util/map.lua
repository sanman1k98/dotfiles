local M = {}

M.defer = true
M.queue = {}
M._queue = {}
M.wk_labels = {}
M.wk = {
  register = function() end,
}

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
  [1]               = false,
  [2]               = false,
  prefix            = false,
  name              = false,
  cond              = false,
  mode              = false,
  buffer            = true,
  desc              = true,
}

local function maparg(k)
  return OPTKEYS[k]
end

local function merge(...)
  return vim.tbl_extend("force", ...)
end

local function fixopts(opts)
  local fixed = {}
  fixed.desc = opts[2] or opts.desc
  for k, v in pairs(opts) do
    if maparg(k) then
      fixed[k] = v
    end
  end
  return fixed
end

local function extractopts(tree)
  local opts = {}
  local keys = {
    mode = true,
    buffer = true,
    cond = true,
    prefix = true,
  }
  for k, v in pairs(tree) do
    if keys[k] then
      opts[k] = v
      tree[k] = nil
    end
  end
  return opts
end

function M.dequeue()
  local mapping = vim.deepcopy(table.remove(M._queue))
  local mode, lhs, rhs, opts = unpack(mapping)
  if type(opts.cond) == "function" and not opts.cond() then
    return
  end
  opts = fixopts(opts)
  if rhs then
    vim.keymap.set(mode, lhs, rhs, opts)
  else
    vim.keymap.del(mode, lhs, opts)
  end
end

function M.dequeue_all()
  while #M._queue > 0 do
    M.dequeue()
  end
  ---@diagnostic disable-next-line:redundant-parameter
  M.wk.register(M.wk_labels)
end

function M._lazykeys(tree, opts)
  local lazykeys = {}
  opts = merge(opts or {}, extractopts(tree))
  if opts.cond == false then
    return lazykeys
  end
  opts.mode = opts.mode or "n"
  opts.prefix = opts.prefix or ""
  for k, v in pairs(tree) do
    local lhs = opts.prefix..k
    if k == "name" then
      M.wk_labels[opts.prefix] = { mode = opts.mode, name = v }
    elseif type(v) == "string" or vim.is_callable(v) then
      table.insert(lazykeys, { lhs, v, mode = opts.mode })
    elseif type(v) == "table" then
      if v[1] then
        if v.cond == false then
          goto continue
        end
        v.desc = v[2] or v.desc
        v[2] = v[1]
        v[1] = lhs
        v.buffer = v.buffer or opts.buffer
        v.mode = v.mode or opts.mode
        table.insert(lazykeys, v)
      else
        local subtree_opts = merge(opts, { prefix = lhs })
        vim.list_extend(lazykeys, M._lazykeys(v, subtree_opts))
      end
    end
    ::continue::
  end
  return lazykeys
end

function M.process(tree, opts)
  opts = merge(opts or {}, extractopts(tree))
  if opts.cond == false then
    return
  end
  opts.mode = opts.mode or "n"
  opts.prefix = opts.prefix or ""
  for k, v in pairs(tree) do
    local lhs = opts.prefix..k
    if k == "name" then
      M.wk_labels[opts.prefix] = { mode = opts.mode, name = v }
    elseif type(v) == "string" or vim.is_callable(v) then
      table.insert(M._queue, { opts.mode, lhs, v, opts })
    elseif type(v) == "table" then
      if v[1] then
        if opts.cond == false then
          goto continue
        end
        local mode = v.mode or opts.mode
        table.insert(M._queue, { mode, lhs, v[1], merge(opts, v) })
      else
        local subtree_opts = merge(opts, { prefix = lhs })
        M.process(v, subtree_opts)
      end
    end
    ::continue::
  end
end

function M.set(mappings)
  M.process(mappings)
  if not M.defer then
    M.dequeue_all()
  end
end

function M.lazykeys(mappings)
  if not vim.tbl_islist(mappings) then
    return M._lazykeys(mappings)
  end
  local lazykeys = {}
  for _, m in ipairs(mappings) do
    vim.list_extend(lazykeys, M._lazykeys(m))
  end
  return lazykeys
end

for name, shortname in pairs(MYALIASES) do
  M[name] = function(mappings)
    mappings.mode = shortname
    return M.set(mappings)
  end
end

return M
