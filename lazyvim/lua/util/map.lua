---@module "lazy.core.handler.keys"

---@class KeymapOpts: vim.keymap.set.Opts
---@field mode? string | string[]
---@field ft? string | string[] Not supported by `util.map.set()`

---@class KeymapGroupOpts: KeymapOpts
---@field prefix? string
---@field label? string

---@class KeymapGroup: KeymapGroupOpts
---@field [integer] LazyKeysSpec

---@alias Keymaps KeymapGroup | LazyKeysSpec | (KeymapGroup|LazyKeysSpec)[]

---@class util.map
local M = {}

-- TODO: setup a simple test for this stuff.

--- Transforms a table defining keymaps into a list of `LazyKeysSpec` tables.
---@param tbl Keymaps
---@return LazyKeysSpec[]
function M.lazykeys(tbl)
  if type(tbl[1]) == "string" then
    ---@cast tbl LazyKeysSpec
    return { tbl }
  end

  ---@type LazyKeysSpec[]
  local ret = {}
  if vim.islist(tbl) then
    ---@cast tbl (LazyKeysSpec|KeymapGroup)[]
    for _, t in ipairs(tbl) do
      if type(t[1]) == "string" then
        ---@cast t LazyKeysSpec
        table.insert(ret, t)
      else
        vim.list_extend(ret, M.lazykeys(t))
      end
    end
    return ret
  end

  --- Default opts
  ---@type KeymapOpts
  local opts = { silent = true }

  local prefix, label
  ---@cast tbl KeymapGroup
  for k, v in pairs(tbl) do
    if k == "prefix" then
      prefix = v
    elseif k == "label" then
      label = v
    elseif type(k) == "number" then
      table.insert(ret, v)
    else
      opts[k] = v
    end
  end

  -- whick-key group names
  if prefix and label then
    table.insert(ret, {
      "", -- prefix will be preprended in the for-loop below
      "", -- which-key v2.0 recognizes "<nop>" or empty keymaps as group names
      desc = label,
      mode = opts.mode,
    } --[[@as LazyKeysSpec]])
  end

  for _, spec in pairs(ret) do
    spec[1] = prefix and prefix .. spec[1] or spec[1]
    spec.mode = spec.mode or opts.mode
    spec.ft = spec.ft or opts.ft
  end

  return ret
end

--- Sets and/or deletes keymaps.
---@param tbl Keymaps
function M.set(tbl)
  local keymaps = M.lazykeys(tbl)
  for _, keymap in pairs(keymaps) do
    local mode, opts = "n", {}
    local lhs, rhs
    for k, v in pairs(keymap) do
      if k == "mode" then
        mode = v
      elseif k == 1 then
        lhs = v
      elseif k == 2 then
        rhs = v
      elseif k == "ft" then
        local str = 'Invalid keymap: unsupported option "%s" used for "%s"\n\n%s'
        local msg = string.format(str, k, lhs, debug.traceback(nil, 2))
        vim.notify(msg, vim.log.levels.ERROR)
      else
        opts[k] = v
      end
    end

    if rhs then
      vim.keymap.set(mode, lhs, rhs, opts)
    else
      vim.keymap.del(mode, lhs, opts)
    end
  end
end

return M
