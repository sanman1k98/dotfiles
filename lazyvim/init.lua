require("util.bootstrap")
require("util.globals")

-- Environment variables defined by terminal emulator (e.g., kitty or wezterm)
local function get_colors()
  if vim.env.CONFIG_COLORS then
    return vim.env.CONFIG_COLORS
  -- Neovim will guess the value of "background" based on terminal colors when starting up.
  -- @see :h default-autocmds
  elseif vim.o.bg == "light" then
    return vim.env.CONFIG_COLORS_LIGHT or "dawnfox"
  else
    return vim.env.CONFIG_COLORS_DARK or "carbonfox"
  end
end

require("lazy").setup({
  spec = {
    {
      -- LazyVim will automatically load "config.*" submodules.
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = function()
          vim.cmd.colors(get_colors())
        end,
      },
    },

    -- Additional plugin specs
    { import = "plug" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { get_colors() } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
