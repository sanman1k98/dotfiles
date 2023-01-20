local o, opt = vim.o, vim.opt

o.background     = "dark"
o.termguicolors  = true
o.winblend       = 10           -- pseudo-transparency for floating widows
o.cmdheight      = 0
o.helpheight     = 20
o.splitright     = true
o.splitbelow     = true
o.scrolloff      = 4
o.sidescrolloff  = 4
o.splitkeep      = "screen"     -- keep text on same screen lin
o.pumheight      = 20           -- max number of items to show in the popup menu
o.pumblend       = 10           -- pseudo-transparency for the popup-men
o.title          = false        -- set window title to "titlestring
o.showtabline    = 1            -- show tabline for more than one ta
o.laststatus     = 0            -- no statusline on startu
o.number         = true         -- show current line numbe
o.relativenumber = true         -- show line numbers relative to curso
o.numberwidth    = 4            -- set width of the number column
o.signcolumn     = "yes"        -- always display signcolumn
o.conceallevel   = 3            -- hide markup for bold and italic
o.list           = true         -- display whitespace characters
o.cursorline     = true         -- highlight location of cursor
o.cursorlineopt  = "both"       -- highlight both the line and number
o.tabstop        = 2
o.shiftwidth     = 2
o.softtabstop    = 2
o.expandtab      = true         -- insert spaces instead of tabs
o.autoindent     = true
o.smartindent    = true
o.wrap           = false
o.breakindent    = true
o.linebreak      = true
o.ignorecase     = true
o.smartcase      = true
o.clipboard      = "unnamedplus"

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
}

opt.mousescroll = {
  "ver:1",
  "hor:1",
}
