My neovim configs
---

## Install script

```sh
sudo apt update
sudo apt upgrade
sudo apt install python3-pip libssl-dev
sudo pip install pynvim

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

mkdir -p ~/.local/bin ~/.local/share

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
# clone project
git clone --depth=1 https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --depth 1 --init --recursive
./3rd/luamake/compile/install.sh
./3rd/luamake/luamake rebuild
cd ..
mv lua-language-server ~/.local/bin/
echo "$PATH=~/.local/bin/lua-language-server/bin" | tee -a ~/.profile

### Python
sudo npm install -g pyright

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
