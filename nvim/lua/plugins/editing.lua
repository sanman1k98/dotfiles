local map = require "util.map"

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
    keys = map.lazykeys {
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
          mode = "i", silent = true, expr = true
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
    enabled = false,
    keys = map.lazykeys {
      ys = true,
      yss = true,
      yS = true,
      ySS = true,
    },
    opts = {
      keymaps = {
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
      },
    },
  },

  { -- adapted from LazyVim
    "echasnovski/mini.surround",
    keys = map.lazykeys {
      {
        gs = { name = "surround" },
      },
      {
        gs = { true, mode = { "n", "v" } },
        ds = true,
        cs = true,
      },
    },
    opts = {
      mappings = {
        add = "gs", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },

  {
    "echasnovski/mini.align",
    keys = map.lazykeys({
      mode = { "n", "v" },
      ga = true,
      gA = true,
    }),
    opts = {
      mappings = {
        start = "ga",
        start_with_preview = "gA",
      },
    },
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
  },

  -- commentary
  { -- adapted from LazyVim
    "echasnovski/mini.comment",
    keys = map.lazykeys({
      gc = true,
      gcc = true,
    }),
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

  -- move
  {
    "echasnovski/mini.move",
    keys = map.lazykeys({
      mode = { "n", "v" },
      ["<m-h>"] = true,
      ["<m-j>"] = true,
      ["<m-k>"] = true,
      ["<m-l>"] = true,
    }),
    config = function()
      require("mini.move").setup()
    end,
  },

  -- split/join
  {
    "Wansmer/treesj",
    keys = map.lazykeys {
      prefix = "<leader>s",
      name = "treesj",
      t = { desc = "toggle",
        function()
          require("treesj.format")._format()
        end,
      },
      s = { desc = "split",
        function()
          require("treesj.format")._format("split")
        end,
      },
      j = { desc = "join",
        function()
          require("treesj.format")._format("join")
        end,
      },
    },
    opts = {
      use_default_keymaps = false,
      langs = {
        -- configure nodes for languages
      },
    },
  }
}
