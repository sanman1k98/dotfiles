local M = setmetatable({}, {  -- make this module load its submodules
  __index = function(self, k)
    local modname = "util."..k
    local submod = require(modname)
    rawset(self, k, submod)
    return submod
  end,
})

M.notify = (function()
  return vim.notify
end)()  -- immediately invoked function expression

function M.err(msg)
  M.notify(msg, vim.log.levels.ERROR)
end

function M.warn(msg)
  M.notify(msg, vim.log.levels.WARN)
end

function M.info(msg)
  M.notify(msg, vim.log.levels.INFO)
end

function M.is_headless()
  return #vim.api.nvim_list_uis() == 0
end

return M
