-- adapted from folke/LazyVim

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    -- TODO: fix statusline flashing
    local dash = require "alpha.themes.dashboard"

    -- removes buttons
    dash.section.buttons.val = {}

    -- adjusts padding
    dash.config.layout[1].val = 8
    dash.config.layout[3].val = 8

    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.autocmd.User.AlphaReady(function()
        vim.cmd.Lazy()
      end)
    end

    require("alpha").setup(dash.config)

    vim.autocmd.User.LazyVimStarted(function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dash.section.footer.val = "loaded "..stats.count.." plugins in "..ms.."ms"
      pcall(vim.cmd.AlphaRedraw)
    end)
  end,
}
