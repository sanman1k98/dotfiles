local autocmd = require("util").autocmd
local opt = vim.opt

opt.termguicolors  = true             -- enable 24-bit RGB in the TUI
opt.cmdheight      = 0                -- number of lines to use for the command line
opt.showcmd        = false            -- don't show partial command
opt.showmode       = false            -- don't show a message on the last line
opt.helpheight     = 20               -- minimum window height when opening a new help window
opt.splitright     = true             -- open vertical splits on the right
opt.splitbelow     = true             -- open horizontal splits on the bottom
opt.scrolloff      = 4                -- minimum number of lines above and below the cursor
opt.sidescrolloff  = 4                -- minimum number of column to left and right of cursor
opt.splitkeep      = "screen"         -- keep text on same screen line when working with horizontal splits
opt.pumheight      = 20               -- max number of items to show in the popup menu
opt.pumblend       = 10               -- pseudo-transparency for the popup-menu
opt.title          = false            -- set window title to 'titlestring'
opt.showtabline    = 1                -- show tabline for more than one tab
opt.laststatus     = 0                -- no statusline on startup
opt.number         = true             -- show current line number
opt.relativenumber = true             -- show line numbers relative to cursor
opt.signcolumn     = "yes"            -- always display signcolumn (fixes choppy 'statuscolumn' rendering on "auto")
opt.conceallevel   = 3                -- hide markup for bold and italic
opt.list           = true             -- display whitespace characters
opt.cursorline     = true             -- highlight location of cursor
opt.cursorlineopt  = "both"           -- highlight both the line and number
opt.tabstop        = 4                -- number of spaces a <tab> in the file counts for; default is 8
opt.shiftwidth     = 0                -- spaces to use for each step of indent; when 0, 'tabstop' value will be used
opt.softtabstop    = 0                -- number of spaces that a <Tab> counts; when negative, 'shiftwidth' value will be used, and 0 disables this
opt.expandtab      = false            -- don't expand <tab> characters into spaces
opt.autoindent     = true             -- take indent for new line from previous line
opt.smartindent    = true             -- smart auto-indenting for C programs; works well for other languages
opt.wrap           = false            -- don't wrap long lines by default
opt.breakindent    = true             -- wrapped lines repeat indent
opt.linebreak      = true             -- wrap long lines at a blank
opt.ignorecase     = true             -- ignore case in search patterns
opt.smartcase      = true             -- don't ignore case when pattern has uppercase letter
opt.spelloptions   = "noplainbuffer"  -- only spellcheck when 'syntax' is enabled, or when extmarks are set
opt.spelllang      = { "en_us" }      -- US English
opt.clipboard      = "unnamedplus"    -- use system clipboard

-- list of flags to shorten messages
opt.shortmess = {
  f = true,   -- use "(3 of 5)" instead of "(file 3 of 5)"
  i = true,   -- use "[noeol]" instead of "[Incomplete last line]"
  l = true,   -- use "999L, 888B" instead of "999 lines, 888 bytes"
  n = true,   -- use "[New]" instead of "[New File]"
  x = true,   -- "[unix]" instead of "[unix format]" and "[mac]" instead of "[mac format]"
  t = true,   -- truncate file message at the start if it is too long	to fit on the command-line
  T = true,   -- truncate other messages in the middle if they are too long to fit on the command line
  o = true,   -- overwrite message for writing a file with subsequent message for reading a file
  O = true,   -- message for reading a file overwrites any previous message
  F = true,   -- don't give the file info when editing a file
  W = true,   -- don't give "written" or "[w]" when writing a file
  I = true,   -- don't give the intro message when starting Vim
  c = true,   -- don't give |ins-completion-menu| messages
  C = true,   -- don't give messages while scanning for ins-completion items
}

-- list of flags to control formatting
opt.formatoptions = {
  t = true,  -- auto-wrap text using "textwidth"
  c = true,  -- auto-wrap comments to "textwidth"; automatically inserts comment leader
  q = true,  -- allow formatting of comment with "gq"
  j = true,  -- remove comment leaders when joining lines
  r = true,  -- automatically insert current comment leader after new line in insert mode
  o = true,  -- automatically insert comment leader after hitting 'o' or 'O' in normal mode
  n = true,  -- when formatting text, recognize numbered lists
}

-- characters to display whitespace
opt.listchars = {
  trail          = "~",    -- trailing whitespace
  eol            = "↲",    -- end of line
  space          = "⋅",    -- a single <space>
  leadmultispace = "⋅⋅⋅•", -- used cyclically to show multiple consecutive leading spaces; overrides "space"
  tab            = "  ",  -- 3 chars `xyz` to show a <tab>; `z` is always used, `x` is prepended, `y` is used as many times as can fit
}

-- characters to use when displaying special items
opt.fillchars = {
  diff = "╱", -- deleted lines when showing diffs; note it is not normal forward slash
  eob  = "•"  -- empty lines at the end of a buffer; by default it is highlighted like `NonText`
}

-- lines to scroll with a mouse
opt.mousescroll = {
  "ver:1",    -- default: 3
  "hor:1",    -- default: 3
}

-- 'statuscolumn'
autocmd.User.VeryLazy(function()
  require("util.gutter").setup()
end, { once = true })
