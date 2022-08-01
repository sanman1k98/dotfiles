local present, tree = pcall(require, "nvim-tree")

if not present then
	return
end

tree.setup {
	view = {
		hide_root_folder = true,
		adaptive_size = true
	},
	renderer = {
		indent_markers = {
			enable = true
		},
		icons = {
			git_placement = "after"
		},
		group_empty = true
	}
}
