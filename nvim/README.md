# NeoVim!

Again, always a work in progress

### Highlights
- use packer.nvim for package management
- telescope for fuzzy finding
- treesitter for to use get the features of Tree-sitter, like better highlighting and indeinting
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
- `conf/` is where my "main" configuration files are
	- `sets` sets my options
	- `maps` sets my mappings
	- `packer` loads all the plugins and their configs
		- some of the configs are small enough to be defined within the plugin specification
		- the bigger configs are extracted to files in the `plugins` folder
- `plugins/` is where the configs for the plugins specified in the 'packer' file are located 
	- `lsp/` is where the setup for individual LSPs shoud go

### TODOs
- [ ] lazy load plugins
- [ ] add some bootstrapping snippets
	- [x] automatically install packer if not installed
	- [ ] install the sumneko lua language server
- [ ] specify OS-specific configuration
	- [ ] `MACOSX_DEPLOYMENT_TARGET` 
- [ ] mappings
	- [ ] LSP features like code actions and stuff
	- [ ] help in a new tab
- [ ] format and add clarity to README
	- [ ] add links to the plugins that I use
	- [ ] try to make more sense somehow
- [ ] try redoing structure and naming
	- [ ] move `conf/` files to `lua/` top-level folder
		- ie: `require('sets')` instead of `require('conf.sets')`
		- *Watch out for namespace clashes*
	- [ ] rename `plugins/` -> `configs/`
