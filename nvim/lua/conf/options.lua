local opt = vim.opt

opt.termguicolors  = true
-- opt.winblend       = 10           -- pseudo-transparency for floating widows
opt.cmdheight      = 0
opt.helpheight     = 20
opt.splitright     = true
opt.splitbelow     = true
opt.scrolloff      = 4
opt.sidescrolloff  = 4
opt.splitkeep      = "screen"     -- keep text on same screen line
opt.pumheight      = 20           -- max number of items to show in the popup menu
opt.pumblend       = 10           -- pseudo-transparency for the popup-menu
opt.title          = false        -- set window title to "titlestring
opt.showtabline    = 1            -- show tabline for more than one ta
opt.laststatus     = 0            -- no statusline on startup
opt.number         = true         -- show current line number
opt.relativenumber = true         -- show line numbers relative to cursor
-- opt.numberwidth    = 4            -- set width of the number column
-- opt.signcolumn     = "yes"        -- always display signcolumn
opt.conceallevel   = 3            -- hide markup for bold and italic
opt.list           = true         -- display whitespace characters
opt.cursorline     = true         -- highlight location of cursor
opt.cursorlineopt  = "both"       -- highlight both the line and number
opt.tabstop        = 2
opt.shiftwidth     = 2
opt.softtabstop    = 2
opt.expandtab      = true         -- insert spaces instead of tabs
opt.autoindent     = true
opt.smartindent    = true
opt.wrap           = false
opt.breakindent    = true
opt.linebreak      = true
opt.ignorecase     = true
opt.smartcase      = true
opt.clipboard      = "unnamedplus"

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

opt.formatoptions = {
  t = true,  -- auto-wrap text using "textwidth"
  c = true,  -- auto-wrap comments to "textwidth"; automatically inserts comment leader
  q = true,  -- allow formatting of comment with "gq"
  j = true,  -- remove comment leaders when joining lines
  r = true,  -- automatically insert current comment leader after new line in insert mode
  o = true,  -- automatically insert comment leader after hitting 'o' or 'O' in normal mode
  n = true,  -- when formatting text, recognize numbered lists
}

opt.listchars = {
  trail = "-",  -- trailing whitespace
  eol   = "↲",  -- end of line
  space = "⋅",
  tab   = " ",
}

opt.fillchars = {
  diff = "╱", -- deleted lines when showing diffs
  eob  = "•"
}

opt.mousescroll = {
  "ver:1",
  "hor:1",
}

require("util.status").setup()
