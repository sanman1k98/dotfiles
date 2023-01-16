---@class PrivateAttributes: {[table]: table} @Stores an object's attributes.
local attr = setmetatable({}, { __mode = "k" })

--- Initialize object's attributes.
---@param o object
---@param t table
---@return object o
function attr.init(o, t)
  attr[o] = t
  return o
end

--- Get object's attributes.
---@param o object
---@param k string
---@return any
function attr.get(o, k) return attr[o][k] end

local M = {}

---@class Context
local Context = {}

---@class Event
---@field _event string|string[]
---@field _pattern? string|string[]
local Event = {}

---@class Group
---@field _group string
local Group = {}

local function apply_ctx(self, opts)
  opts = opts or {}
  local ctx = attr.get(self, "ctx")
  opts.group = attr.get(ctx, "group") or opts.group
  opts.buffer = attr.get(ctx, "buffer") or opts.buffer
  return opts
end

function Event:__call(handler, opts)
  opts = apply_ctx(self, opts)
  opts.pattern = rawget(self, "_pattern") or opts.pattern
  if type(handler) == "string" and handler:sub(1, 1) == ":" then
    opts.command = handler:sub(2)
  else
    opts.callback = handler
  end
  return vim.api.nvim_create_autocmd(self._event, opts)
end

local function make_Event(ctx, e, pat)
  local self = { _event = e, _pattern = pat, }
  attr.init(self, { ctx = ctx })
  return setmetatable(self, Event)
end

function Event:__index(k)
  if not rawget(self, "_pattern") then
    return make_Event(attr.get(self, "ctx"), self._event, k)
  else
    return nil
  end
end

function Context:__index(event)
  return make_Event(self, event)
end

Group.__index = Group

function Group:__call(arg)
  if arg == true then
    return vim.api.nvim_create_augroup(self._group, { clear = true })
  elseif arg == nil then
    return vim.api.nvim_create_augroup(self._group, { clear = false })
  elseif type(arg) == "function" then
    vim.api.nvim_create_augroup(self._group, { clear = false })
    local rm = function() vim.api.nvim_create_augroup(self._group, { clear = true }) end
    arg(attr[self].ctx, rm)
  end
end

local function make_Context(g, buf)
  local self = attr.init({}, {
    group = g,
    buffer = buf,
  })
  return setmetatable(self, Context)
end

local function make_Group(g)
  local self = { _group = g, }
  attr.init(self, { ctx = make_Context(g) })
  return setmetatable(self, Group)
end

--- Index by event name and register an event handler.
M.on = make_Context()

--- Index by group name and register multiple event handlers.
M.ns = setmetatable({}, {
  __index = function(_, k)
    return make_Group(k)
  end,
})

--- Index by event name and register an event handler for a buffer.
local current_buf_ctx = make_Context(nil, 0)
M.buf = setmetatable({}, {
  __index = function(_, k)
    if not type(k) == "number" then
      return current_buf_ctx[k]
    else
      return make_Context(nil, k)
    end
  end,
})

--- Index by event name and trigger handlers that match any given given criteria.
M.emit = setmetatable({}, {
  ---@param k string|string[] event name(s)
  __index = function(_, k)
    ---@param data? any arbitrary data to pass to the callbacks
    ---@param opts? table a table of autocmd options
    return function(data, opts)
      opts = opts or {}
      opts.data = data
      vim.api.nvim_exec_autocmds(k, opts)
    end
  end,
})

--- Clear event handlers that match the given criteria, or delete a single
--- event handler with the given id.
M.rm = function(arg)
  if type(arg) == "number" then
    vim.api.nvim_del_autocmd(arg)
  elseif type(arg) == "table" then
    if arg.group then
      if type(arg.group) == "number" then
        vim.api.nvim_del_augroup_by_id(arg.group)
      else
        vim.api.nvim_del_augroup_by_name(arg.group)
      end
    else
      vim.api.nvim_clear_autocmds(arg)
    end
  end
end

return M
