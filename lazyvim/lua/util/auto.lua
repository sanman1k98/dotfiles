local M = {}

--- Index by event names to get `Event` objects.
---@class Autocmd : { [string | string[]]: Event }
---@field package _group string | nil
---@field package _buf integer | nil
local Autocmd = {}

--- Used to create autocommands.
---@class Event : { [string | string[]]: Event | nil }
---@field package _event string | string[]
---@field package _pattern string | string[] | nil
---@field package _group string | nil
---@field package _buf integer | nil
local Event = {}

--- Used to create groups and define autocommands within them.
---@class Augroup
---@field package _group string
local Augroup = {}

---@param group string?
---@param buf number?
---@return Autocmd
local function create_autocmd_object(group, buf)
  local self = { _group = group, _buf = buf }
  return setmetatable(self, Autocmd)
end

---@param event string | string[]
---@param pattern? string | string[]
---@param group? string
---@param buf? integer
---@return Event
local function create_event_object(event, pattern, group, buf)
  local self = {
    _event = event,
    _pattern = pattern,
    _group = group,
    _buf = buf,
  }
  return setmetatable(self, Event)
end

---@param event string | string[]
---@return Event
function Autocmd:__index(event)
  return create_event_object(
    event,
    nil, -- no pattern
    rawget(self, "_group"),
    rawget(self, "_buf")
  )
end

--- Create an autocommand.
---@param handler string | fun(args: vim.api.keyset.create_autocmd.callback_args): boolean?
---@param opts vim.api.keyset.create_autocmd
---@return integer autocmd_id
function Event:__call(handler, opts)
  opts = opts or {}
  opts.group = opts.group or rawget(self, "_group")
  opts.buffer = opts.buffer or rawget(self, "_buf")
  opts.pattern = opts.pattern or rawget(self, "_pattern")

  if type(handler) == "string" and handler:sub(1, 1) == ":" then
    opts.command = handler:sub(2)
  else
    opts.callback = handler
  end

  return vim.api.nvim_create_autocmd(self._event, opts)
end

---@param k string | string[] An `Event` method name or an autocommand pattern.
function Event:__index(k)
  local method = Event[k]

  if method then
    return method
  elseif rawget(self, "_pattern") == nil then
    return create_event_object(
      self._event,
      k, -- use as pattern
      rawget(self, "_group"),
      rawget(self, "_buf")
    )
  end

  return nil
end

---@alias AugroupSpec fun(au: Autocmd, clear: fun(): integer)

--- Create an autocommand group.
---@param spec? AugroupSpec An callback that accepts an `Autocmd` object and optionally a `clear` callback to clear the autocommands in the group.
---@return integer | nil augroup_id
function Augroup:__call(spec)
  if not spec then
    return vim.api.nvim_create_augroup(self._group, { clear = false })
  end

  local au = create_autocmd_object(self._group)
  local clear = function()
    return vim.api.nvim_create_augroup(self._group, { clear = true })
  end

  spec(au, clear)
end

--- Indexable by event names.
M.autocmd = create_autocmd_object(nil, nil)

--- Indexable by arbitrary group names.
---@type { [string]: Augroup }
M.augroup = setmetatable({}, {
  ---@param group string
  ---@return Augroup
  __index = function(_, group)
    local self = { _group = group }
    return setmetatable(self, Augroup)
  end,
})

return M
