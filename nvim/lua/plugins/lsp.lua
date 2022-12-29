local spec = {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "folke/neodev.nvim",
  },
  event = "VimEnter",
}

spec.config = function()
  require("mason").setup()
  require("mason-lspconfig").setup {
    ensure_installed = { "sumneko_lua" },
  }

  do  -- so we don't have to specify capabilities for every server
    local lsp_util = require "lspconfig.util"
    local cmp  = require "cmp_nvim_lsp"

    local base_config = lsp_util.default_config -- extended by all server configs
    local updated_capabilities = vim.tbl_deep_extend(
      "force",
      base_config.capabilities,   -- vim.lsp.protocol.make_client_capabilities()
      cmp.default_capabilities()  -- cmp supports additional capabilities
    )

    base_config.capabilities = updated_capabilities
  end

  -- automatically setup servers installed by Mason
  require("mason-lspconfig").setup_handlers {
    function(server)  -- for servers that don't have a dedicated handler
      require("lspconfig")[server].setup {}
    end,
    sumneko_lua = function()
      require("neodev").setup({
        library = {
          plugins = false,
        }
      })
      require("lspconfig").sumneko_lua.setup {}
    end,
  }
end

return spec
