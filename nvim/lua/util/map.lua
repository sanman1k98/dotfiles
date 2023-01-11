---@class KeymapOpts @Valid options for `vim.keymap.set()` and `vim.keymap.del()`.
---@field desc? string
---@field expr? boolean
---@field remap? boolean
---@field buffer? integer
---@field nowait? boolean
---@field silent? boolean
---@field unique? boolean
---@field replace_termcodes? boolean

---@class KeymapArglist @Arguments passed to `vim.keymap.set()`
---@field [1] string|string[] mode
---@field [2] string lhs
---@field [3] string|fun() rhs
---@field [4] KeymapOpts? opts

---@alias key string A single key in a key sequence

---@class KeymapNodeOpts: KeymapOpts @Defines KeymapOpts to be merged with KeymapInfo or to be applied to children KeymapNodes
---@field name? string `which-key` group label
---@field prefix? string prepended to all top-level key(s)
---@field mode? string|string[]
---@field cond? boolean|fun():boolean if false or returns false all KeymapNodes 

---@class KeymapInfo: KeymapOpts @Use to set or delete a keymap
---@field [1] boolean|string|function rhs; false deletes a keymap
---@field [2]? string desc
---@field mode? string|string[]
---@field cond? boolean|fun():boolean if false or returns false the keymap will not be set

---@alias KeymapNode KeymapNodeOpts|table<key, KeymapNode|KeymapInfo>

---@alias KeymapNodeKeys key[] List of keys in a KeymapNode whose corresponding value references either a KeymapInfo or another KeymapNode.

---@alias KeymapTree KeymapNode Root KeymapNode

---@class LazyKeys: KeymapOpts @Keymaps for lazy to load plugins on
---@field [1] string lhs
---@field [2]? string|fun() rhs
---@field mode? string|string[]

local opt_names = {
  "desc",
  "expr",
  "remap",
  "buffer",
  "nowait",
  "silent",
  "unique",
  "replace_termcodes",
}

local nodeopt_names = {
  "name",
  "mode",
  "cond",
  "prefix",
}

---@class map
local M = {}

M.defer = true

M._queue = {}
M._wk_mappings = {}

function M._dequeue()
  local mapping = table.remove(M._queue)
  local mode, lhs, rhs, opts, cond = unpack(mapping)
  if cond and not cond() then return end
  if rhs then
    vim.keymap.set(mode, lhs, rhs, opts)
  else
    vim.keymap.del(mode, lhs, opts)
  end
end

function M._loadall()
  while #M._queue > 0 do
    M._dequeue()
  end
  if M.wk then
    M.wk.register(M._wk_mappings)
  end
end

function M.loadall()
  M.defer = false
  local loaded, wk = pcall(require, "which-key")
  M.wk = loaded and wk or nil
  M._loadall()
end

---@param k string
---@return boolean #True if `k` is a field name in KeymapNodeOpts.
local function is_opt(k)
  for _, opt in ipairs(nodeopt_names) do
    if k == opt then return true end
  end
  for _, opt in ipairs(opt_names) do
    if k == opt then return true end
  end
  return false
end

--- Get `opts` and a list of keys to traverse for a given `node`.
---@param node KeymapNode
---@param opts? table A table to set KeymapNodeOpts. (If omitted, a new table will be created.)
---@return KeymapNodeOpts opts The mutated `opts` table.
---@return KeymapNodeKeys? keys nil if an option "cond" was found to be false
local function processnode(node, opts)
  opts = opts or {}
  local keys = {}
  for k, v in pairs(node) do
    if k == "cond" and v == false then return opts, nil
    elseif is_opt(k) then opts[k] = v
    else table.insert(keys, k)
    end
  end
  if opts.cond == false then
    return opts, nil
  end
  opts.prefix = opts.prefix or ""
  opts.mode = opts.mode or "n"
  if opts.name and not M._wk_mappings[opts.prefix] then
    M._wk_mappings[opts.prefix] = {
      name = opts.name,
      mode = opts.mode,
      buffer = opts.buffer,
    }
  end
  return opts, keys
end

---@param opts KeymapNodeOpts
---@param info KeymapInfo
---@return KeymapOpts
local function mergeinfo(opts, info)
  local ret = {}
  for _, k in ipairs(opt_names) do
    ret[k] = info[k] or opts[k]
  end
  ret.desc = ret.desc or info[2]
  return ret
end

--- Recursively find keymaps to set or delete and add them to `M._queue`. Set `M._wk_mappings` for any group names found.
---@param node KeymapNode
---@param opts? KeymapNodeOpts Passed down from parent KeymapNode.
function M._process(node, opts)
  local keys; opts, keys = processnode(node, opts)    -- get opts and list of keys for `node`
  if not keys then return end
  for _, k in ipairs(keys) do                       -- iterate through list of keys
    local lhs = opts.prefix..k
    local v = node[k]
    if                                              -- check if `v`:
      v == false                                    -- deletes a mapping
      or type(v) == "string" or vim.is_callable(v)  -- sets a mapping
    then
      local cond = vim.is_callable(opts.cond) and opts.cond
      table.insert(M._queue, {                      -- add it to the queue
        opts.mode,
        lhs,
        v,                                          -- rhs or false
        mergeinfo(opts, {}),  --[[@as KeymapOpts]]
        cond or nil,
      })
      goto continue
    end
    assert(type(v) == "table")
    if v.cond == false then
      goto continue
    elseif v[1] ~= nil then                             -- `v` is type KeymapInfo
      local info = v  --[[@as KeymapInfo]]
      local mode = info.mode or opts.mode
      local rhs = info[1]
      local o = mergeinfo(opts, info)
      local cond = info.cond or opts.cond
      table.insert(M._queue, {                      -- add it to the queue
        mode,
        lhs,
        rhs,                                        -- rhs or false
        o,  --[[@as KeymapOpts]]
        vim.is_callable(cond) and cond or nil
      })
    elseif v.desc then
      v[1] = v.desc; v.desc = nil
      M._wk_mappings[lhs] = v
    else
      local o = vim.tbl_extend("force", opts, { prefix = lhs })
      M._process(v --[[@as KeymapTree]], o)
    end
    ::continue::
  end
end

---@param node KeymapNode
---@param opts? KeymapNodeOpts
---@return LazyKeys[]
function M._lazykeys(node, opts)
  local ret = {}
  local keys; opts, keys = processnode(node, opts)    -- get opts and list of keys for `node`
  if not keys then return ret end
  for _, k in ipairs(keys) do                       -- iterate through list of keys
    local lhs = opts.prefix..k
    local v = node[k]
    if
      v == true
      or type(v) == "string"
      or vim.is_callable(v)
    then
      local t = mergeinfo(opts, {})
      local rhs = v ~= true and v or nil
      t[1], t[2], t.mode = lhs, rhs, opts.mode
      table.insert(ret, t --[[@as LazyKeys]])
      goto continue
    end
    assert(type(v) == "table")
    if v[1] or v.desc then                            -- `v` is type KeymapInfo
      local info = v  --[[@as KeymapInfo]]
      local t = mergeinfo(opts, info)
      local rhs = info[1] ~= true and info[1] or nil
      t[1], t[2], t.mode = lhs, rhs, info.mode or opts.mode
      table.insert(ret, t --[[@as LazyKeys]])
    else
      local o = vim.tbl_extend("force", opts, { prefix = lhs })
      vim.list_extend(ret, M._lazykeys(v, o))
    end
    ::continue::
  end
  return ret
end

---@param keymaps KeymapTree|KeymapTree[]
function M.set(keymaps)
  if not keymaps[1] then
    M._process(keymaps)
  else
    for _, m in ipairs(keymaps) do
      M._process(m)
    end
  end
  if not M.defer then
    M._loadall()
  end
end

---@param keymaps KeymapTree|KeymapTree[]
---@return LazyKeys[]
function M.lazykeys(keymaps)
  if not keymaps[1] then
    return M._lazykeys(keymaps)
  end
  local ret = {}
  for _, m in ipairs(keymaps) do
    vim.list_extend(ret, M._lazykeys(m))
  end
  return ret
end

return M
