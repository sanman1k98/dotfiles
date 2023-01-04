local notify = require "util.notify"
local map = require "util.map"

---@param client table
return function(client, bufnr)
  local capabilities = client.server_capabilities
  local has_hover = capabilities.hoverProvider and true or false

  map.normal({
    ["<leader>rn"] = { vim.lsp.buf.rename, "rename symbol" },
    ["<leader>wl"] = { desc = "list workspace folders",
      function()
        notify.info(vim.inspect(vim.lsp.buf.list_workspace_folders()), "LSP: workspace folders")
      end,
    },
    ["gD"] = { vim.lsp.buf.declaration, "goto declaration" },
    ["gd"] = { vim.lsp.buf.definition, "goto definition" },
    ["gr"] = { vim.lsp.buf.references, "list all references" },
    ["gi"] = { vim.lsp.buf.implementation, "goto implementation" },
    ["<c-k>"] = { vim.lsp.buf.signature_help, "display signature help" },
    ["K"] = { desc = "display hover info",
      function()
        if has_hover then vim.lsp.buf.hover()
        else notify.warn("Hover not supported", "LSP")end
      end,
    },
  }, { buffer = bufnr })
end
