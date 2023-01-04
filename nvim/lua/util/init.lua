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

util.auto = util.load.mod "luauto"

return util
