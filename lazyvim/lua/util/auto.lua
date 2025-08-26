local M = {}

--- Index by event names to get `Event` objects.
---@class util.auto.Autocmd : { [string | string[]]: util.auto.Event }
---@field package _group string | nil
---@field package _buf integer | nil
local Autocmd = {}

--- Used to create autocommands.
---@class util.auto.Event : { [string | string[]]: util.auto.Event | nil }
---@field package _event string | string[]
---@field package _pattern string | string[] | nil
---@field package _group string | nil
---@field package _buf integer | nil
local Event = {}

--- Used to create groups and define autocommands within them.
---@class util.auto.Augroup
---@field package _group string
local Augroup = {}

---@param group string?
---@param buf number?
---@return util.auto.Autocmd
local function create_autocmd_object(group, buf)
  local self = { _group = group, _buf = buf }
  return setmetatable(self, Autocmd)
end

---@param event string | string[]
---@param pattern? string | string[]
---@param group? string
---@param buf? integer
---@return util.auto.Event
local function create_event_object(event, pattern, group, buf)
  local self = {
    _event = event,
    _pattern = pattern,
    _group = group,
    _buf = buf,
  }
  return setmetatable(self, Event)
end

---@param k string | string[]
---@return util.auto.Event
function Autocmd:__index(k)
  local method = Autocmd[k]

  if method then
    return method
  end

  return create_event_object(
    k, -- use as event
    nil, -- no pattern
    rawget(self, "_group"),
    rawget(self, "_buf")
  )
end

--- Clear autocommands matching `opts`.
---@param opts? vim.api.keyset.clear_autocmds
function Autocmd:clear(opts)
  if not opts and rawget(self, "_group") then
    vim.api.nvim_create_augroup(rawget(self, "_group"), { clear = true })
  else
    opts = opts or {}
    opts.buffer = opts.buffer or rawget(self, "_buf")
    opts.group = opts.group or rawget(self, "_group")
    vim.api.nvim_clear_autocmds(opts)
  end
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

---@alias AugroupSpec fun(au: util.auto.Autocmd, clear: fun(): integer)

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
---@type { [string]: util.auto.Augroup }
M.augroup = setmetatable({}, {
  ---@param group string
  ---@return util.auto.Augroup
  __index = function(_, group)
    local self = { _group = group }
    return setmetatable(self, Augroup)
  end,
})

return M
