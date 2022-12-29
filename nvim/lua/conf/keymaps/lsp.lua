return function(_, bufnr)
  require("util.map").normal({
    ["<leader>vr"] = { vim.lsp.buf.rename, "rename symbol" },
    ["<leader>wl"] = { desc = "list workspace folders",
      function()
        vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
    }
  }, { buffer = bufnr })
end
