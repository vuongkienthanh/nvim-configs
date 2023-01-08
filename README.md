My neovim configs for dev on windows
---

Prerequisites :
- chocolatey
- git
- rustup

### Use POWERSHELL with admins
```sh
choco install fd ripgrep nodejs zig
choco install neovim --pre
choco install python3 --version=3.10

## rust toolchains
rustup default nightly

## packer: neovim package manager
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"


## clone this repo
git clone https://github.com/vuongkienthanh/nvim-configs.git "$env:LOCALAPPDATA\nvim\"
```


### Start nvim and sync
```sh
:PackerSync
```
