local present, catppuccin = pcall(require, 'catppuccin')

if not present then
	return
end

local flavors = {
	'latte',
	'frappe',
	'macchiato',
	'mocha'
}

vim.g.catppuccin_flavour = flavors[4]

catppuccin.setup {}

vim.cmd.colorscheme 'catppuccin'
