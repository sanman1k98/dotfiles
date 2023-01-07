local M = {}
local map = require "util.map"

function M.on_attach(client, bufnr)
  local function has(provider)
    return client.server_capabilities[provider.."Provider"] ~= nil
  end

  map.set {
    buffer = bufnr,
    g = {
      d = { desc = "definitions",
        function()
          require("telescope.builtin").lsp_definitions()
        end
      },
      D = { desc = "declarations",
        function()
          require("telescope.builtin").lsp_declarations()
        end
      },
      r = { desc = "references",
        function()
          require("telescope.builtin").lsp_references()
        end
      },
      I = { desc = "implementations",
        function()
          require("telescope.builtin").lsp_implementations()
        end
      },
    },

    K = { vim.lsp.buf.hover, "hover" },

    ["<c-k>"] = { desc = "signature help",
      vim.lsp.buf.signature_help,
      mode = { "n", "i", },
      cond = has "signatureHelp",
    },

    ["<leader>e"] = {
      name = "edit",
      a = { desc = "code actions",
        vim.lsp.buf.code_action,
        cond = has "codeAction"
      },
      r = { desc = "rename",
        vim.lsp.buf.rename,
        cond = has "rename",
      }
    },
  }
end

return M
