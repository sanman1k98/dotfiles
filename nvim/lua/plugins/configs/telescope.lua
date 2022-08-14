local present, telescope = pcall(require, 'telescope')

if not present then
	return
end

telescope.setup {
	defaults = {
		prompt_prefix = '   ',
		selection_caret = '  ',
		entry_prefix = '  ',
		sorting_strategy = 'ascending',
		layout_config = {
			horizontal = {
				prompt_position = 'top',
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		-- TODO: set highlights to get that borderless look
	},

	pickers = {
		find_files = {
			find_command = {'fd', '--type', 'file', '--exclude', '{.git,node_modules}'},
			hidden = true
		},
	}
}
