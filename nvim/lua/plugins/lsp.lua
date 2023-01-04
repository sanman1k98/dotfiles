local spec = {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "folke/neodev.nvim",
  },
  event = "VeryLazy",
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

  local on_attach = require "conf.keymaps.lsp"

  local function common_setup(server)
    require("lspconfig")[server].setup {
      on_attach = on_attach,
    }
  end

  -- automatically setup servers installed by Mason
  require("mason-lspconfig").setup_handlers {
    common_setup,   -- index 1 used as default handler
    sumneko_lua = function()
      require("neodev").setup({
        library = {
          plugins = false,
        }
      })
      common_setup "sumneko_lua"
    end,
  }
end

return spec
