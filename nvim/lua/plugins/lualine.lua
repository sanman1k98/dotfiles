return require('lualine').setup {
	options = {
		theme = 'tokyonight'
	},
	sections = {
		lualine_x = {'encoding', 'filetype'}
	}
}
