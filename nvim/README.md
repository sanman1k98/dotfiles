# NeoVim!

Again, always a work in progress

### Highlights
- use packer.nvim for package management
- telescope for fuzzy finding
- treesitter to get the features of Tree-sitter, like better highlighting and indeinting
- nvim-tree to show a file tree on the side
- lspconfigs to use the builtin LSP client
- null-ls to provide some formatting functionality
- coq for autocompletions
- autopairs to automatically insert closing quotes, parens, backets, etc
- trouble for a pretty list of diagnostics
- aesthetic stuff
	- github theme
	- indent-blankline for indentaion guides
	- lualine for a neat looking status line
	- zen-mode for some distraction free coding
	- circles instead of nerd font glyphs

### Structure
- `sets` does options
- `maps` does mappings
- `plugins` specifies the plugins to be loaded
	- some of the configs are small enough to be defined within the plugin specification
	- the bigger configs are extracted to files in the `configs/` folder
- `configs/` is where the configs for somce of the plugins specified in the 'plugins' file are located 
	- `lsp/` is where the setup for individual LSPs shoud go

### TODOs
- [ ] filetype.lua
	- `:help vim.filetype`
	- to enable do this but in lua
		- `let g:do_filetype_lua = 1`
		- `let g:did_load_filetypes = 0`
- [ ] add some images
	- [ ] screenshots of the terminal with neovim running
	- [ ] a rough diagram scribbled in GoodNotes that I use to help myself visualize
- [x] lazy load plugins
- [ ] add some bootstrapping snippets
	- [x] automatically install packer if not installed
	- [ ] install the sumneko lua language server
- [x] specify OS-specific configuration
	- [x] `MACOSX_DEPLOYMENT_TARGET` 
- [ ] mappings
	- [ ] try out the new `vim.keymap` API
		- adding descriptions to keymaps via `desc` option in the opts table
		- rhs can be lua function
		- `:help vim.api.nvim_set_keymap`
	- [ ] better mouse scrolling on macOS
	- [ ] LSP features like code actions and stuff
	- [ ] help in a new tab
- [ ] format and add clarity to README
	- [ ] add links to the plugins that I use
	- [ ] try to make more sense somehow
- [x] try redoing structure and naming
	- [x] move `conf/` files to `lua/` top-level folder
		- ie: `require('sets')` instead of `require('conf.sets')`
		- *Watch out for namespace clashes*
	- [x] rename `plugins/` -> `configs/`

### Ideas
- [ ] plugins to tryout
	- [ ] heirline.nvim
	- [ ] nvim-scrollbar
	- [ ] Termcolors.nvim
	- [ ] telescope-file-browser.nvim
	- [ ] impatient.nvim
- [ ] make neovim a full on word processor
	- [ ] search for plugins for editing markdown
	- [ ] vale: syntax-aware linter for prose
	- [ ] delete Microsoft Word and Pages
- [ ] git integration
	- [ ] vim fugitive or some lua alternative?
