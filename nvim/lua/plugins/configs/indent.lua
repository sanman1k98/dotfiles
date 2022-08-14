local present, indent = pcall(require, 'indent_blankline')

if not present then
	return
end

indent.setup {
	show_current_context = true,
	filetype_exclude = { 'terminal', 'help', 'packer', 'man', 'markdown' },
	show_end_of_line = true,
	space_char_blankline = ' ',
}
