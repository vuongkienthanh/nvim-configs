My neovim configs
---

## Install script

```sh
## Prerequisites
mkdir -p ~/.local/bin ~/.local/share ~/.build_from_source ~/.config/nvim
cd ~/.build_from_source

sudo apt update
sudo apt upgrade
sudo apt install python3-pip libssl-dev ninja-build \
  gettext libtool libtool-bin autoconf automake \
  cmake g++ pkg-config unzip curl doxygen xclip \
  fd-find

## build neovim from source
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
pip install pynvim

## rg
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb

## node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install node
nvm use node

## rust toolchains
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup default nightly

## package manager for neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

## lsp servers

### Rust
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz |\
  gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer

### Lua
mkdir ~/.local/bin/lua-language-server/
curl -L https://github.com/sumneko/lua-language-server/releases/download/3.5.3/lua-language-server-3.5.3-linux-x64.tar.gz |\
  tar -C ~/.local/bin/lua-language-server/ -xzf -
# add to $PATH
echo "export PATH=\$PATH:~/.local/bin/lua-language-server/bin" | tee -a ~/.profile
echo "export PATH=\$PATH:~/.local/bin/lua-language-server/bin" | tee -a ~/.bashrc

### Python
npm install --location=global pyright

### TOML
cargo install --features lsp --locked taplo-cli

### JSON, CSS, HTML, Javascript/Typescript
npm i --location=global vscode-langservers-extracted

### Svelte
npm i --location=global svelte-language-server

### null-ls
pip install black

### others
pip install sqlfluff

## win32yank in wsl
curl -LO https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip |\
  unzip win32yank-x64.zip win32yank.exe -d ~/.local/bin/
```
## Apply config
git clone https://github.com/vuongkienthanh/nvim-configs.git ~/.config/nvim/
## open nvim
:PackerSync
