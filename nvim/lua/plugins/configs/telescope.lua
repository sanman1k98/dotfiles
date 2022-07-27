local telescope = require'telescope'

telescope.setup {
	pickers = {
		find_files = {
			hidden = true
		},
		lsp_code_actions = {
			layout_strategy = 'cursor'
		}
	}
}
