local submodules = {
  colors = true,
  notify = true,
  kitty = true,
  map = true,
}

local M = setmetatable({}, {
  __index = function(self, k)
    if submodules[k] then
      self[k] = require("util."..k)
    elseif
      k == "autocmd"
      or k == "augroup"
      or k == "autocmd_rm"
    then
      require "util._auto"
    end
    return self[k]
  end,
})

--- Check if a given command exists on the path.
---@param command string
---@return boolean
function M.has(command)
  return vim.fn.executable(command) == 1
end

--- True when nvim is running in headless mode.
M.in_headless = #vim.api.nvim_list_uis() == 0

--- True when running in an instance of kitty.
M.in_kitty = vim.env.TERM == "xterm-kitty"

--- Index `vim.api` without the "nvim_" prefix.
M.api = setmetatable({}, {
  __index = function(_, k)
    return vim.api["nvim_"..k]
  end,
})

--- Prepend `lazy.nvim` to the runtimepath and setup XDG directories. Setup
--- more utility modules.
function M.setup()
  M.notify.setup()
  if M.in_kitty then
    M.autocmd.UIEnter(function()
      M.kitty.setup()
    end, { once = true })
  end
  -- set in .config/zsh/init/variables.zsh
  local config = vim.env.CONFIG_BRANCH
  if config == nil then
    M.notify.warn "`$CONFIG_BRANCH` environment variable not specified"
  elseif config ~= "main" then
    -- TODO: set XDG dirs here or with zsh script?
  end
  local lazypath = vim.fn.stdpath("data").."/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)
end

--- Toggle an option or options; notify user unless `silent` is specified. Can
--- specify an option to toggle as a string or list of strings. Can also
--- specify an option to toggle between two values by passing a table a key as
--- the option name, and a list containing two items as its corresponding
--- value.
---@param option string|string[]|table<string, {[1]:any, [2]:any}>
---@param silent? boolean defaults to false
function M.toggle(option, silent)
  silent = silent == true
  local opt = vim.opt_local
  local msg = not silent and { "# Toggled:" } or nil
  if type(option) == "string" then option = { option } end
  for k, v in pairs(option) do
    local name, old, new
    if type(k) == "number" then
      name = v
      old = opt[name]:get()
      new = not old
      opt[name] = new
    else
      name = k
      old = opt[name]:get()
      if old == v[1] then
        opt[name] = v[2]
        new = v[2]
      else
        opt[name] = v[1]
        new = v[1]
      end
    end
    if msg then
      table.insert(msg, ("- **%s**: `%s` -> `%s`"):format(name, old, new))
    end
  end
  if not msg then return end
  M.notify.info(table.concat(msg, "\n"))
end

--- Fast implementation to check if a table is a list
---@param t table
---@see lazy.nvim/lua/lazy/core/util.lua
function M.is_list(t)
  local i = 0
  ---@diagnostic disable-next-line: no-unknown
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil then
      return false
    end
  end
  return true
end

local function can_merge(v)
  return type(v) == "table" and (vim.tbl_isempty(v) or not M.is_list(v))
end

--- Merges the values similar to vim.tbl_deep_extend with the **force** behavior,
--- but the values can be any type, in which case they override the values on the left.
--- Values will me merged in-place in the first left-most table. If you want the result to be in
--- a new table, then simply pass an empty table as the first argument `vim.merge({}, ...)`
--- Supports clearing values by setting a key to `vim.NIL`
---@generic T
---@param ... T
---@return T
---@see lazy.nvim/lua/lazy/core/util.lua
function M.merge(...)
  local values = { ... }
  local ret = values[1]

  if ret == vim.NIL then
    ret = nil
  end

  for i = 2, #values, 1 do
    local value = values[i]
    if can_merge(ret) and can_merge(value) then
      for k, v in pairs(value) do
        ---@diagnostic disable-next-line: need-check-nil
        ret[k] = M.merge(ret[k], v)
      end
    elseif value == vim.NIL then
      ret = nil
    else
      ret = value
    end
  end
  return ret
end

-- Copied from LazyVim
function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    size = { width = 0.9, height = 0.9 },
  }, opts or {})
  require("lazy.util").float_term(cmd, opts)
end

return M
