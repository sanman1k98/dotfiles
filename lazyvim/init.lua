require("util").bootstrap_lazy()

require("lazy").setup({
  spec = {
    {
      -- LazyVim will automatically load "config.*" submodules.
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        -- Environment variable defined by terminal emulator (e.g., wezterm)
        colorscheme = vim.env.CONFIG_COLORS or "dawnfox",
      },
    },

    -- For vim mode in VSCode; only loads when `vim.g.vscode` is set
    { import = "lazyvim.plugins.extras.vscode" },

    -- Add, delete, replace surrounding pairs (e.g., quotes, parens, tags)
    { import = "lazyvim.plugins.extras.coding.mini-surround" },

    -- Highlight colors in code; supports Tailwind CSS
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

    -- TypeScript
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.astro" },

    -- Python
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.formatting.black" },

    -- Other languages
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.yaml" },

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
  install = { colorscheme = { "dawnfox" } },
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
