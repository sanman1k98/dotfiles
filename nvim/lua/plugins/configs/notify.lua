local present, notify = pcall(require, 'notify')

if not present then
	return
end

-- change notify function globally

vim.notify = notify.setup {
	max_width = 35,
	stages = 'fade',
}
