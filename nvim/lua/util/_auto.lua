local util = require "util"

---@class PrivateAttributes: {[object]: table} @Stores an object's attributes.
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

---@class Context: {[string|string[]]: Event}
local Context = {}

---@class Event: {[string|string[]]: Event|nil}
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

function Event:exec(data, opts)
  opts = opts or {}
  opts.data = data
  opts.modeline = opts.modeline == true
  opts.pattern = rawget(self, "_pattern")
  vim.api.nvim_exec_autocmds(self._event, opts)
end

---@private
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

---@private
function Event:__index(k)
  if not rawget(self, "_pattern") then
    return make_Event(attr.get(self, "ctx"), self._event, k)
  else
    return nil
  end
end

---@private
function Context:__index(event)
  return make_Event(self, event)
end

---@private
Group.__index = Group

function Group:del()
  vim.api.nvim_del_augroup_by_name(self._group)
end

---@private
function Group:__call(arg)
  if arg == nil then
    return vim.api.nvim_create_augroup(self._group, { clear = false })
  elseif type(arg) == "function" then
    vim.api.nvim_create_augroup(self._group, { clear = false })
    local clear = function() vim.api.nvim_create_augroup(self._group, { clear = true }) end
    arg(attr[self].ctx, clear)
  end
end

---@return Context
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

--- Indexable by autocommand event names and returns an "Event" object.
---
--- Call the Event as a function with an event handler to create an
--- autocommand.
---
--- Execute an Event by calling its method `:exec()`.
util.autocmd = make_Context()

--- Delete an autocommand given its id, or delete multiple autocommands that
--- match the corresponding criteria.
---@param arg integer|table
util.autocmd_rm = function(arg)
  if type(arg) == "number" then
    vim.api.nvim_del_autocmd(arg)
  elseif type(arg) == "table" then
    vim.api.nvim_clear_autocmds(arg)
  end
end

--- Index by group name to return a "Group" object.
---
--- Get the id of a Group by calling it as a function without arguments.
---
--- Define multiple autocommands in a Group by calling it as a function and
--- passing a callback that defines autocommands.
util.augroup = setmetatable({}, {
  __index = function(_, k)
    return make_Group(k)
  end,
})
