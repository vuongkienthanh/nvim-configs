require('packer').startup(function()
  use {'wbthomason/packer.nvim'}
  use {'kyazdani42/nvim-web-devicons'}
  use {'tpope/vim-surround'}
  use {'lukas-reineke/indent-blankline.nvim',
    config = function() require'indent_blankline'.setup() end}
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
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'SirVer/ultisnips',
      config = function() vim.fn.system('mkdir','-p','~/.config/nvim/UltiSnips') end
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
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    } end }
end)
