local plugin = {
  "echasnovski/mini.nvim",
  event = "InsertEnter",
}

plugin.config = function()
  require("mini.pairs").setup()
  require("mini.surround").setup()
  require("mini.comment").setup()
  return true
end

return plugin
