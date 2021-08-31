local set = require('conf.utils').set

local o, wo, bo = vim.o, vim.wo, vim.bo
local buffer = {o, bo}
local window = {o, wo}

-- set('OPT', VAL)

set('number', true, window)
set('relativenumber', true, window)
set('numberwidth', 4, window)
set('scrolloff', 10)
set('wrap', false, window)

set('tabstop', 2, buffer)
set('shiftwidth', 2, buffer)
set('smarttab', true)
set('shiftround', true)
set('smartindent', true, buffer)

set('hidden', true)

set('splitbelow', true)
set('splitright', true)

set('completeopt', 'menuone,noselect')
