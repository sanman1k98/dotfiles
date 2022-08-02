local present1, feline = pcall(require, 'feline')
local present2, cat_int = pcall(require, 'catppuccin.groups.integrations.feline')

if not ( present1 or present2 ) then
	return
end

feline.setup {
	components = cat_int.get()
}

feline.winbar.setup {}
