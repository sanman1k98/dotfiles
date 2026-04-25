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
        acp = {
          opts = {
            show_presets = false,
          }
        },
        http = {
          LlamaBarn = function ()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "llamabarn",
              formatted_name = "LlamaBarn",
              env = {
                url = "http://localhost:2276",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "mudler/Qwen3.6-35B-A3B-APEX-GGUF:unknown",
                  choices = {
                    ["mudler/Qwen3.6-35B-A3B-APEX-GGUF:unknown"] = {
                      formatted_name = "Qwen 3.6 35B-A3B",
                      meta = { context_window = 131072 },
                      opts = { has_vision = false, can_reason = true, },
                    },
                    ["gemma-4-e4b"] = {
                      formatted_name = "Gemma 4 E4B",
                      meta = { context_window = 131072 },
                      opts = { has_vision = true, can_reason = true, },
                    },
                  }
                }
              }
            })
          end,
          opts = {
            show_presets = false,
          }
        }
      },
      interactions = {
        chat = { adapter = "LlamaBarn" },
        inline = { adapter = "LlamaBarn" },
        cmd = { adapter = "LlamaBarn" },
        background = {
          adapter = "LlamaBarn",
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
    },
    keys = map.lazykeys {
      prefix = "<leader>C",
      label = "CodeCompanion",
      { "C", function () vim.cmd.CodeCompanionChat("Toggle") end, desc = "Open Chat" },
      { "a", vim.cmd.CodeCompanionActions, desc = "Chat Actions" },
    },
  },
}
