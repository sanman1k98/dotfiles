local present, telescope = pcall(require, 'telescope')

if not present then 
	return 
end

telescope.setup {
	pickers = {
		find_files = {
			find_command = {'fd', '--type', 'file', '--exclude', '{.git,node_modules}'},
			hidden = true
		},
		lsp_code_actions = {
			theme = 'cursor'
		}
	}
}
