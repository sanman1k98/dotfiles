
local au = vim.api.nvim_create_autocmd

do -- plugins
  require "plugins"
  au("BufWritePost", {
    pattern = vim.fn.stdpath("config") .. "/lua/plugins.lua",
    callback = function()
      vim.cmd.source "<amatch>"
    end
  })
end

