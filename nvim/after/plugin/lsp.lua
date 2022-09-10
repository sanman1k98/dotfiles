
local setup = function()
  local packadd = vim.cmd.packadd

  packadd "mason.nvim"
  packadd "mason-lspconfig.nvim"
  packadd "nvim-lspconfig"

  local loaded_mason, mason = pcall(require, "mason")
  local loaded_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
  if not (loaded_mason and loaded_mason_lsp) then
    vim.notify("Mason plugins not found", vim.log.levels.ERROR)
    return
  end

  mason.setup()
  mason_lsp.setup {
    ensure_installed = {
      "sumneko_lua",
    },
    automatic_installation = true,
  }


  packadd "lspsaga.nvim"
  local loaded_saga, saga = pcall(require, "lspsaga")
  if not loaded_saga then
    vim.notify("lspsaga plugin not found", vim.log.levels.ERROR)
    return
  end
  
  saga.init_lsp_saga()


  packadd "lspkind.nvim"
  local loaded_lspkind, lspkind = pcall(require, "lspkind")
  if not loaded_lspkind then
    vim.notify("lspkind plugin not found", vim.log.levels.WARN)
    return
  end

  lspkind.init()
end


vim.api.nvim_create_autocmd("VimEnter", {
  callback = setup,
  once = true,
})
