local M = {
  background     = "dark",
  termguicolors  = true,
  winblend       = 10,
  cmdheight      = 0,
  helpheight     = 20,
  splitright     = true,
  splitbelow     = true,
  scrolloff      = 4,
  sidescrolloff  = 4,
  splitkeep      = "screen",     -- keep text on same screen line
  pumheight      = 20,           -- max number of items to show in the popup menu
  title          = true,         -- set window title to "titlestring"
  showtabline    = 1,            -- show tabline for more than one tab
  laststatus     = 0,            -- no statusline on startup
  number         = true,         -- show current line number
  relativenumber = true,         -- show line numbers relative to cursor
  numberwidth    = 4,            -- set width of the number column
  signcolumn     = "yes",        -- always display signcolumn
  conceallevel   = 3,            -- hide markup for bold and italic
  cursorline     = true,         -- highlight location of cursor
  cursorlineopt  = "both",
  tabstop        = 2,
  shiftwidth     = 2,
  softtabstop    = 2,
  expandtab      = true,
  autoindent     = true,
  smartindent    = true,
  wrap           = false,
  breakindent    = true,
  linebreak      = true,
  ignorecase     = true,
  smartcase      = true,
  clipboard      = "unnamedplus",
}

M.shortmess = {
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

M.formatoptions = {
  t = true,  -- auto-wrap text using "textwidth"
  c = true,  -- auto-wrap comments to "textwidth"; automatically inserts comment leader
  q = true,  -- allow formatting of comment with "gq"
  j = true,  -- remove comment leaders when joining lines
  r = true,  -- automatically insert current comment leader after new line in insert mode
  o = true,  -- automatically insert comment leader after hitting 'o' or 'O' in normal mode
  n = true,  -- when formatting text, recognize numbered lists
}

M.listchars = {
  trail = "-",  -- trailing whitespace
  eol   = "↲",  -- end of line
  space = "⋅",
  tab   = " ",
}

M.fillchars = {
  diff = "╱", -- deleted lines when showing diffs
}

M.mousescroll = {
  "ver:1",
  "hor:1",
}

for k, v in pairs(M) do
  vim.opt[k] = v
end

return M
