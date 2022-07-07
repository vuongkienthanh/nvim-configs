My neovim configs
---

## Install script

```sh
## Prerequisites
mkdir -p ~/.local/bin ~/.local/share ~/.build_from_source
cd ~/.build_from_source

sudo apt update
sudo apt upgrade
sudo apt install python3-pip libssl-dev ninja-build \
  gettext libtool libtool-bin autoconf automake \
  cmake g++ pkg-config unzip curl doxygen

## build neovim from source
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=Release
make install
sudo pip install pynvim

## nodejs LTS
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

## rust toolchains
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup default nightly

## package manager for neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

## lsp servers

### SQL
npm i -g sql-language-server

### Rust
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz |\
  gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer

### Lua
mkdir ~/.local/bin/lua-language-server/
curl -L https://github.com/sumneko/lua-language-server/releases/download/3.2.3/lua-language-server-3.2.3-linux-x64.tar.gz |\
  tar -C ~/.local/bin/lua-language-server/ -xzf
# add to $PATH
echo "$PATH=~/.local/bin/lua-language-server/bin" | tee -a ~/.profile

### Python
sudo npm install -g pyright
pip install autopep8

### TOML
cargo install --locked taplo-cli

### JSON, CSS, HTML, Javascript/Typescript
sudo npm i -g vscode-langservers-extracted

### Svelte
sudo npm i -g svelte-language-server

## win32yank in wsl
curl -L https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x86.zip |\
  unzip win32yank-x64.zip win32yank.exe -d ~/.local/bin/
```
