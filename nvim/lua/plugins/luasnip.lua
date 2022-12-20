local plugin = {
  "L3MON4D3/LuaSnip",
  requires = {
    "rafamadriz/friendly-snippets",
  },
  event = "InsertEnter",
}

plugin.config = function()
  require("luasnip.loaders.from_vscode").lazy_load()
end

return plugin
