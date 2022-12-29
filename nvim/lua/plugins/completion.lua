local spec = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "echasnovski/mini.nvim",
  },
}

spec.config = function()
  local cmp = require "cmp"
  require("mini.pairs").setup()
  require("mini.surround").setup()
  require("mini.comment").setup()

  cmp.setup {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<CR>"]  = cmp.mapping.confirm({ select = true }),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<C-e>"] = cmp.mapping.abort(),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
    }),
  }
end

return spec
