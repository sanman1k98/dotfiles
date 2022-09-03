local au = require "utils.auto"
local packadd = vim.cmd.packadd

local lsp_plugins = {
  "mason.nvim",
  "nvim-lspconfig",
  "mason-lspconfig.nvim",
  "null-ls.nvim"
}


local lazy_load_lsp = function(tb)
  for _, plugin in ipairs(lsp_plugins) do
    packadd(plugin)
  end
end
