# My config for neovim

## Installation & Update
For different platforms, check out:
- wsl: https://github.com/vuongkienthanh/nvim-configs-wsl
- linux: https://github.com/vuongkienthanh/nvim-configs-linux

## Commands:
### Set up First time:
- `:MasonToolsInstall` 
### Keep up to date
- `:Lazy`: package manager
- `:Mason`: lsp installer

## Keymaps:

`<leader> = <space>`

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
- `C-e`: abort
- `C-y`: select

### lsp
- `<leader>ff`: format
- `<leader>d`: open diagnostics
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
- `ic`, `ac`: class
- `im`, `am`: method call
- `io`, `ao`: conditional
- `il`, `al`: loop
- `ib`, `ab`: block
