return {
  -- LSP servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = true,
  },

  -- LSP configs
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function() -- so we don't have to specify capabilities for every server
      local lsp_util = require "lspconfig.util"
      local cmp  = require "cmp_nvim_lsp"

      local base_config = lsp_util.default_config -- extended by all server configs
      local updated_capabilities = vim.tbl_deep_extend(
        "force",
        base_config.capabilities,   -- vim.lsp.protocol.make_client_capabilities()
        cmp.default_capabilities()  -- cmp supports additional capabilities
      )

      base_config.capabilities = updated_capabilities
    end,
  },

  -- configure lua-language-server for nvim
  {
    "folke/neodev.nvim",
    config = {
      library = {
        plugins = false,
      }
    }
  },

  -- automatic LSP setup
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "folke/neodev.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local mason_lspconfig = require "mason-lspconfig"
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(require("plugins.lsp.servers")),
      }
      mason_lspconfig.setup_handlers {
        function(server)
          local configs = require "plugins.lsp.servers"
          local opts = configs[server] or {}
          opts.on_attach = function(client, bufnr)
            require("plugins.lsp.keymaps").on_attach(client, bufnr)
          end
          require("lspconfig")[server].setup(opts)
        end,
      }
    end,
  },
}
