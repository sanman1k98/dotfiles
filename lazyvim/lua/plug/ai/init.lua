local map = require("util.map")

return {
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
