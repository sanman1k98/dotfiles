local spec = {
  "L3MON4D3/LuaSnip",
  dependencies = "rafamadriz/friendly-snippets",
  event = "InsertEnter",
}

spec.config = function()
  require("luasnip.loaders.from_vscode").lazy_load()
end

return spec
