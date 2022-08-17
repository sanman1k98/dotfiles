
local function clone_paq()
  vim.fn.system {
    "git",
    "clone",
    "--depth=1",
    "https://github.com/savq/paq-nvim.git",
    vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
  }
end

local function bootstrap(plugins)
  clone_paq()
  vim.cmd.packadd "paq-nvim"
  vim.api.nvim_create_autocmd("User", {
    pattern = "PaqDoneInstall",
    command = "quit"
  })
  require("paq")(plugins):install()
end

return bootstrap
