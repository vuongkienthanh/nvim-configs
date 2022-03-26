-- Bootstraping packer.nvim
fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Main
require('packer').startup(function()
  use {'wbthomason/packer.nvim'}
  use {'kyazdani42/nvim-web-devicons'}
  use {'tpope/vim-surround'}
  use {'numToStr/Comment.nvim',
    config = function() require'Comment'.setup() end }
  use {'nvim-lualine/lualine.nvim',
    config = function() require'lualine'.setup() end }
  use {'windwp/nvim-autopairs',
    config = function() require'nvim-autopairs'.setup() end }
  use {'crusoexia/vim-monokai',
    config = function() vim.cmd('colorscheme monokai') end }
  use {"norcalli/nvim-colorizer.lua",
    config = function() require'colorizer'.setup() end }

  -- Explorer g? to help
  use {'kyazdani42/nvim-tree.lua',
    config = function() require'nvim-tree'.setup() end }

  -- lsp
  use {'neovim/nvim-lspconfig'}
  use {'onsails/lspkind-nvim'}
  use {'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'SirVer/ultisnips',
    } }
  use {'nvim-treesitter/nvim-treesitter',
    requires = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "andymass/vim-matchup",
    },
    run = ':TSUpdate',
    config = function() require'nvim-treesitter.configs'.setup {
      ensure_installed = {
        "rust",
        "python",
        "lua",
        "json",
        "svelte",
        "javascript",
        "typescript",
        "html",
        "css",
        "markdown",
      },
      highlight = {enable = true},
      autotag = {enable = true},
      context_commentstring = {enable = true},
      matchup = {enable = true},
    } end }
  -- Bootstraping
  if packer_bootstrap then require'packer'.sync() end
end)
