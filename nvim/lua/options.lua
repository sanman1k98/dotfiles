local opt = vim.opt

opt.termguicolors = true
opt.title = true

-- window statusline
opt.laststatus = 3

-- show tabline if there is more than one tab
opt.showtabline = 1

-- show cursor location
opt.cul = true

opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.signcolumn = 'yes'

opt.scrolloff = 8
opt.wrap = false
opt.breakindent = true
opt.linebreak = true

-- default value is " "tcqj""
opt.formatoptions = opt.formatoptions
	+ 'c' -- autowrap comments to `textwidth`
	- 'r' -- don't continue comments on `<CR>`
	- 'o' -- ...or when opening a newline
	- 'a' -- *don't autoformat*

local indent = 2
opt.tabstop = indent
opt.shiftwidth = indent
opt.softtabstop = indent
opt.autoindent = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

-- disable nvim intro
opt.shortmess:append 'sI'

-- show whitespace
opt.list = true
opt.listchars:append("space:⋅")
opt.listchars:append("tab:··")		-- third char "" is always shown
opt.listchars:append("eol:↲")

opt.mouse = 'nvi'

-- integrate with system clipboard
opt.clipboard = 'unnamedplus'

opt.hidden = true

opt.helpheight = 10
opt.splitright = true
opt.splitbelow = true
