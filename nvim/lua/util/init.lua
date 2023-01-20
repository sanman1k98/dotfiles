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

return util
