# IDE neovim config on WSL

## on windows side

use `win32yank` instead of clip.exe ( doesn't support utf8)

```sh
choco install win32yank
```

## on wsl side
```sh
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install
    neovim\
    unzip ripgrep fd-find\
    gcc g++ make\
    python3-full python3-venv python-pynvim\
```

# More packages for specific languages
### Python
```sh
sudo apt install python3-dev python3-doc
```

### Nodejs
```sh
sudo apt install nodejs npm
```

### Rust
```sh
sudo apt install rust-all rust-doc rust-src
```
