# My config for neovim

## Installation
For different platforms, check out:
- wsl: https://github.com/vuongkienthanh/nvim-configs-wsl
- linux: https://github.com/vuongkienthanh/nvim-configs-linux

## Commands:
- `:Lazy`: package manager
- `:Mason`: lsp installer
- `:TSUpdateSync`: download treesitter nessessary files
- [`:Neoconf`](https://github.com/folke/neoconf.nvim): project-wise lsp settings
    - [ example config ](./.neoconf.json)
- `:KanagawaCompile`: colorscheme compile, faster loading time, required everytime colorscheme changed


## Keymaps:
### IDE
- `<leader>tab`: file explorer
- `<leader>fb`: buffers
- `<leader>fg`: grep
- `<leader>qq`: local diagnostics
- `<leader>qa`: project diagnostics
- `<leader>s`: leap
- `C-j`: color code input
- `gcc`, `v_gc`, `v_gb`: toggle comment

### autocomplete
- `C-n`: next
- `C-p`: prev
- `C-e`: abort and revert
- `C-f`: abort but change to selection
- `enter`: select and expand

### lsp
- `<leader>ff`: format
- `<leader>e`: open float
- `C-]`: jump to definition
- `C-T`: jump back
- `K`: hover
- `grn`: rename
- `gra`: code actions
- `grr`: references
- `gri`: toggle inlay hints
- `i_C-s`: signature help

## Text-objects:
- `if`, `af`: function
- `ic`, `ac`: method call
