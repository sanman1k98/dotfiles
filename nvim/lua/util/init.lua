local util = setmetatable({}, {
  __index = function(self, k)
    local submod = require("util."..k)
    rawset(self, k, submod)
    return submod
  end,
})

function util.is_headless()
  return #vim.api.nvim_list_uis() == 0
end

util.api = setmetatable({}, {
  __index = function(_, k)
    return vim.api["nvim_"..k]
  end,
})

--- Prepend `lazy.nvim` to the runtimepath and setup XDG directories.
function util.setup()
  util.notify.setup()
  -- set in .config/zsh/init/variables.zsh
  local config = vim.env.CONFIG_BRANCH
  if config == nil then
    util.notify.warn "`$CONFIG_BRANCH` environment variable not specified"
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
function util.toggle(option, silent)
  silent = silent == true
  local opt = vim.opt_local
  local msg = not silent and { "# Toggled option:\n" } or nil
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
      table.insert(msg, ("- *%s*: `%s` -> `%s`"):format(name, old, new))
    end
  end
  if not msg then return end
  util.notify.info(table.concat(msg, "\n"))
end

return util
