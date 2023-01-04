-- adapted from folke/LazyVim
return function()
  local dash = require "alpha.themes.dashboard"

  dash.section.buttons.val = {
    -- TODO add some buttons
  }

  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.autocmd.User.AlphaReady(vim.cmd.Lazy)
  end

  require("alpha").setup(dash.config)

  vim.autocmd.User.LazyVimStarted(function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dash.section.footer.val = "loaded "..stats.count.." plugins in "..ms.."ms"
    pcall(vim.cmd.AlphaRedraw)
  end)
end
