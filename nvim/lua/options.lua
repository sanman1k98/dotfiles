local opt = vim.opt

opt.termguicolors = true
opt.title = true

opt.showtabline = 2
opt.laststatus = 3

opt.cul = true

opt.number = true
opt.relativenumber = true
opt.numberwidth = 4

opt.scrolloff = 8
opt.wrap = false
opt.breakindent = true
opt.linebreak = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

-- disable nvim intro
opt.shortmess:append 'sI'

-- show whitespace
opt.list = true
opt.listchars:append("space:⋅")
opt.listchars:append("tab:··»")		-- third char "»" is always shown
opt.listchars:append("eol:↲")

opt.mouse = 'nvi'

opt.clipboard = 'unnamedplus'

opt.hidden = true

opt.helpheight = 10
opt.splitright = true
opt.splitbelow = true
