local map = require("util.map")

return {
  -- split/join
  {
    "Wansmer/treesj",
    opts = function ()
      local lang_utils = require("treesj.langs.utils")
      local html = require("treesj.langs.html")
      local ts = require("treesj.langs.typescript")

      local langs = {
        astro = lang_utils.merge_preset(html, ts)
      }

      return {
        use_default_keymaps = false,
        max_join_length = 150,
        langs = langs,
      }
    end,
    keys = map.lazykeys {
      prefix = "<leader>j",
      label = "split/join",
      { "j", function() require("treesj").toggle() end, desc = "Toggle split" },
    },
  },

  -- AI-powered coding
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
      "CodeCompanionCmd",
    },
    opts = {
      adapters = {
        http = {
          LlamaBarn = function ()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "llamabarn",
              formated_name = "LlamaBarn",
              env = {
                url = "http://localhost:2276",
                chat_url = "/v1/chat/completions",
              },
            })
          end
        }
      },
      interactions = {
        chat = { adapter = "Llamabarn" },
        inline = { adapter = "Llamabarn" },
        cmd = { adapter = "Llamabarn" },
        background = {
          adapter = "Llamabarn",
          chat = {
            callbacks = {
              ["on_ready"] = {
                actions = {
                  "interactions.background.builtin.chat_make_title",
                },
                -- Enable "on_ready" callback which contains the title generation action
                enabled = true,
              },
            },
            opts = {
              -- Enable background interactions generally
              enabled = true,
            },
          },
        },
      }
    }
  },
}
