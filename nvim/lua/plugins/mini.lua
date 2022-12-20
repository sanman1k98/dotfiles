local plugin = {
  "echasnovski/mini.nvim",
  opt = false,
}

plugin.config = function()
  local auto = require "luauto"
  local au = auto.cmd

  au.InsertEnter(function()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.comment").setup()
    return true
  end)
end

return plugin
