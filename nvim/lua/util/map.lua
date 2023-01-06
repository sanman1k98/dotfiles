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

--- Get the opts from a group of mappings
--@param mappings table
-- local function getopts(mappings)
--   local opts = {}
--   for k, v in pairs(mappings) do
--     if optkey(k) then opts[k] = v end
--   end
--   if vim.is_callable(opts.cond) then
--     opts.cond = opts.cond()
--   end
--   return opts
-- end

--- Traverse a group of mappings structured as a prefix-tree and generate lhs,
--- rhs, and opts for each valid mapping.
--@param mappings table: prefix-tree node
--@param opts table|nil: overrides opts found in mappings
-- local function parse(mappings, opts)
--   opts = merge(getopts(mappings), opts or {})
--   opts.mode = opts.mode or "n"
--   if opts.cond ~= nil and not opts.cond then
--     return
--   end
--   if not opts.prefix then -- we're at the root of the group
--     opts.prefix = opts.prefix or ""
--   end
--   local co = coroutine
--   return co.wrap(function()
--     local subgroups = {}  -- subnodes/children to parse
--     for k, info in pairs(mappings) do -- iter through this node
--       local mode = opts.mode
--       local lhs = opts.prefix..k
--       if k == "name" then -- wk group name
--         co.yield(mode, opts.prefix, nil, { mode = mode, name = info })
--       elseif optkey(k) then -- don't do anything
--       elseif type(info) == "string" or vim.is_callable(info) then -- rhs value for mapping
--         co.yield(mode, lhs, info, opts)
--       elseif info == false then -- del keymap
--         co.yield(mode, lhs, false, opts)
--       elseif type(info) == "table" then -- 
--         if info[1] then -- has rhs value for mapping
--           mode = info.mode or mode
--           co.yield(mode, lhs, info[1], merge(opts, info))
--         else  -- subnode to parse
--           subgroups[lhs] = info
--         end
--       end
--     end
--     for prefix, subgroup in pairs(subgroups) do -- go through children
--       opts.prefix = prefix
--       for mode, lhs, rhs, args in parse(subgroup, opts) do -- recurse
--         co.yield(mode, lhs, rhs, args)
--       end
--     end
--   end)
-- end

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

function M.lazykeys(tree, opts)
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
        vim.list_extend(lazykeys, M.lazykeys(v, subtree_opts))
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
  local lazykeys = M.process(mappings)
  if M.defer then return lazykeys end
  vim.schedule_wrap(M.dequeue_all)
  return lazykeys
end

--- Sets a group of mappings (defaults to normal mode).
-- function M.set(mappings, options)
--   if M.defer then
--     return table.insert(M.queue, { mappings, options })
--   end
--   local labels = M.wk and {} or nil
--   for mode, lhs, rhs, opts in parse(mappings, options) do
--     if rhs == nil then  -- labels have mode in opts
--       if M.wk then labels[lhs] = opts end
--     elseif rhs then
--       vim.keymap.set(mode, lhs, rhs, fixopts(opts))
--     elseif not rhs then
--       vim.keymap.del(mode, lhs, fixopts(opts))
--     end
--   end
--   if labels then M.wk.register(labels) end
-- end

-- function M.loadall()
--   if M.defer == false then
--     return
--   end
--   local loaded_wk, wk = pcall(require, "which-key")
--   M.wk = loaded_wk and wk or false
--   M.defer = false
--   for _, item in ipairs(M.queue) do
--     M.set(unpack(item))
--   end
--   M.queue = nil
-- end

for name, shortname in pairs(MYALIASES) do
  M[name] = function(mappings)
    mappings.mode = shortname
    return M.set(mappings)
  end
end

return M
