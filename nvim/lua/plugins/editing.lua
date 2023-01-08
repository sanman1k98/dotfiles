return {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    keys = require("util.map").lazykeys {
      {
        ["<tab>"] = {
          function()
            local snippet = require "luasnip"
            if snippet.jumpable(1) then
              return snippet.jump(1)
            else
              return "<tab>"
            end
          end,
          mode = "i", remap = true, silent = true, expr = true
        },
      },
      {
        ["<tab>"] = {
          function()
            require("luasnip").jump(1)
          end,
          mode = "s",
        },
        ["<s-tab>"] = {
          function()
            require("luasnip").jump(-1)
          end,
          mode = { "s", "i" },
        },
      },
    },
    config = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },

  -- autocomplete
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None,
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
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },

  -- autopairs
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup()
    end,
  },

  -- surround
  {
    "kylechui/nvim-surround",
    keys = {
      "<leader>s",
      "ds",
      "cs"
    },
    config = {
      keymaps = {
        normal = "<leader>s",
        normal_cur = "<leader>ss",
        normal_line = "<leader>S",
        normal_cur_line = "<leader>SS",
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
      },
    },
  },

  { -- copied from LazyVim
    enabled = false,
    "echasnovski/mini.surround",
    keys = { "gz" },
    config = function()
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup({
        mappings = {
          add = "gza", -- Add surrounding in Normal and Visual modes
          delete = "gzd", -- Delete surrounding
          find = "gzf", -- Find surrounding (to the right)
          find_left = "gzF", -- Find surrounding (to the left)
          highlight = "gzh", -- Highlight surrounding
          replace = "gzr", -- Replace surrounding
          update_n_lines = "gzn", -- Update `n_lines`
        },
      })
    end,
  },

  -- commentary
  "JoosepAlviste/nvim-ts-context-commentstring",
  { -- copied from LazyVim
    "echasnovski/mini.comment",
    event = "InsertEnter",
    config = function()
      require("mini.comment").setup {
        hooks = {
          pre = function()
            require("ts_context_commentstring.internal").update_commentstring()
          end,
        }
      }
    end,
  },

  -- split/join
  {
    "Wansmer/treesj",
    keys = require("util.map").lazykeys {
      ["<leader>j"] = {
        name = "split/join",
        j = { desc = "toggle",
          function()
            require("treesj.format")._format()
          end,
        },
        s = { desc = "split",
          function()
            require("treesj.format")._format("split")
          end,
        },
      },
    },
    langs = {
      -- configure nodes for languages
    },
    config = function(plugin)
      require("treesj").setup {
        use_default_keymaps = false,
        langs = plugin.langs,
      }
    end,
  }
}
