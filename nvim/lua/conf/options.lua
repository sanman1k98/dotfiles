local opt = vim.opt


-- UI
opt.termguicolors  = true
opt.winblend       = 10

opt.cmdheight      = 0

opt.helpheight     = 20
opt.splitright     = true
opt.splitbelow     = true
opt.splitkeep      = "screen" -- keep text on same screen line

opt.pumheight      = 20       -- max number of items to show in the popup menu

opt.title          = true     -- set window title to "titlestring"
opt.showtabline    = 1        -- show tabline for more than one tab
opt.laststatus     = 0        -- no statusline on startup

opt.number         = true     -- show current line number
opt.relativenumber = true     -- show line numbers relative to cursor
opt.numberwidth    = 4        -- set width of the number column
opt.signcolumn     = "yes"    -- always display signcolumn

opt.conceallevel   = 3        -- hide markup for bold and italic

opt.cursorline     = true     -- highlight location of cursor
opt.cursorlineopt  = {
  "number",                   -- the number in the numbercol
  "line",                     -- the text line
}


-- indenting
local width     = 4
opt.tabstop     = width
opt.shiftwidth  = width
opt.softtabstop = width
opt.expandtab   = false
opt.autoindent  = true
opt.smartindent = true


-- formatting
opt.formatoptions = opt.formatoptions
  + "t"  -- auto-wrap text using "textwidth"
  + "c"  -- auto-wrap comments to "textwidth"; automatically inserts comment leader
  + "q"  -- allow formatting of comment with "gq"
  + "j"  -- remove comment leaders when joining lines



-- messages
opt.shortmess = opt.shortmess

  + "f"   -- "(file 3 of 5)"          -> "(3 of 5)"
  + "i"   -- "[Incomplete last line]" -> "[noeol]"
  + "l"   -- "999 lines, 888 bytes"   -> "999L, 888B"
  + "n"   -- "[New File]"             -> "[New]"
  + "x"   -- "[unix format]"          -> "[unix]"

  + "t"   -- truncate file message if it is too long to fit on the command line
  + "T"   -- truncate other messages in the middle if they are too long to fit on the command line
  + "o"   -- overwrite message for writing a file with subsequent message for reading a file
  + "O"   -- message for reading a file overwrites any previous message
  + "F"   -- don't give the file info when editing a file

opt.shortmess = opt.shortmess
  + "I"               -- disable intro message
  + "s"               -- do not show messages when wrapping search




-- show whitespace
opt.list = true
opt.listchars:append {
  space = "⋅",
  tab   = " ",
  eol   = "↲",
}

opt.fillchars:append {
  diff = "╱",       -- Note: not a normal forward slash
}


-- scrolling
opt.scrolloff = 4
opt.mousescroll = {
  "ver:1",            -- default: 3
  "hor:1",            -- default: 6
}



-- miscellaneous
opt.wrap        = false
opt.breakindent = true
opt.linebreak   = true

opt.ignorecase  = true
opt.smartcase   = true
opt.clipboard   = "unnamedplus" -- integrate with system clipboard
