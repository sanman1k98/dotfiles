local au = require "utils.auto"
local env = vim.env
local opt = vim.opt



do -- UI
  if env.TERM == "xterm-kitty" or env.COLORTERM == "truecolor" then
    opt.termguicolors = true
  end

  opt.helpheight = 12
  opt.splitright = true
  opt.splitbelow = true

  opt.pumheight = 30        -- max number of items to show in the popup menu

  opt.title = true          -- set window title to "titlestring"
  opt.showtabline = 1       -- show tabline for more than one tab
  opt.laststatus = 3        -- global statusline

  opt.number = true         -- show current line number
  opt.relativenumber = true -- show line numbers relative to cursor
  opt.numberwidth = 4       -- set width of the number column
  opt.signcolumn = "yes"    -- always display signcolumn
end


do --highlight on yank
  au.user.on_yank(function()
    vim.highlight.on_yank {
      timeout = 200,
      on_macro = true
    }
  end)
end


do -- highlight current cursor location
  opt.cursorline = true
  au.user.leave_window(function() vim.opt_local.cursorline = false end)
  au.user.enter_window(function() vim.opt_local.cursorline = true end)
end


do -- indenting
  local width = 2
  opt.tabstop = width
  opt.shiftwidth = width
  opt.softtabstop = width
  opt.autoindent = true
  opt.smartindent = true
end


do -- formatting
  opt.formatoptions = opt.formatoptions

    + "t"               -- auto-wrap text using "textwidth"
    + "c"               -- auto-wrap comments to "textwidth"; automatically inserts comment leader
    + "q"               -- allow formatting of comment with "gq"
    + "j"               -- remove comment leaders when joining lines

end


do -- messages
  opt.shortmess = opt.shortmess

    + "f"               -- "(file 3 of 5)" -> "(3 of 5)"
    + "i"               -- "[Incomplete last line]" -> "[noeol]"
    + "l"               -- "999 lines, 888 bytes" -> "999L, 888B"
    + "n"               -- "[New File]" -> "[New]"
    + "x"               -- "[unix format]" -> "[unix]"

    + "t"               -- truncate file message if it is too long to fit on the command line
    + "T"               -- truncate other messages in the middle if they are too long to fit on the command line
    + "o"               -- overwrite message for writing a file with subsequent message for reading a file
    + "O"               -- message for reading a file overwrites any previous message
    + "F"               -- don't give the file info when editing a file

  opt.shortmess = opt.shortmess
    + "I"               -- disable intro message
    + "s"               -- do not show messages when wrapping search

end


do -- show whitespace
  opt.list = true
  opt.listchars:append {
    space = "⋅",
    tab = " ",
    eol = "↲",
  }
end


do -- scrolling
  opt.scrolloff = 4
  opt.mousescroll = {
    "ver:1",            -- default: 3
    "hor:1",            -- default: 6
  }
end


do -- miscellaneous
  opt.wrap = false
  opt.breakindent = true
  opt.linebreak = true

  opt.ignorecase = true
  opt.smartcase = true
  opt.clipboard = "unnamedplus" -- integrate with system clipboard
end
