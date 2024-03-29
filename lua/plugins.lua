require("packer").init {
  git = {
    clone_timeout = false,
  },
}
require("packer").startup(function()
  use {
    "wbthomason/packer.nvim",
    "kyazdani42/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  }
  use { "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup {
        compile = true,
        dimInactive = true,
        theme = 'dragon',
      }
      vim.cmd.colorscheme "kanagawa"
    end }
  use { "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup() end }
  use { "lukas-reineke/indent-blankline.nvim",
    config = function() require "indent_blankline".setup() end }
  use { "numToStr/Comment.nvim",
    config = function()
      require "Comment".setup {
        mapping = {
          extra = false
        }
      }
    end }
  use { "ggandor/leap.nvim",
    requires = {
      "tpope/vim-repeat",
    },
  }
  use { "windwp/nvim-autopairs",
    config = function()
      local Rule = require('nvim-autopairs.rule')
      local npairs = require('nvim-autopairs')
      npairs.setup {
        check_ts = true,
      }
      npairs.add_rules({},
        Rule("'", "'", "-rs")
      )
    end }
  use { "uga-rosa/ccc.nvim",
    config = function()
      local ccc = require("ccc")
      ccc.setup {
        inputs = {
          ccc.input.rgb,
        },
        outputs = {
          ccc.output.hex,
          ccc.output.css_rgb,
          {
            name = "RGB args",
            str = function(RGB)
              return ("(%d, %d, %d)"):format(table.unpack(RGB))
            end,
          }
        }
      }
    end
  }
  -- explorer
  use { "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    config = function()
      require("neo-tree").setup({ close_if_last_window = true })
    end
  }

  -- lsp
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "onsails/lspkind-nvim",
      "simrat39/rust-tools.nvim",
    },
  }
  use {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup {
        logging = false,
        filetype = {
          python = {
            require("formatter.filetypes.python").black
          }
        }
      }
    end
  }
  use {
    "williamboman/mason.nvim",
    requires = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "rust-analyzer",
          "taplo",
          "yaml-language-server",
          "lua-language-server",
          "html-lsp",
          "css-lsp",
          "eslint-lsp",
          "typescript-language-server",
          "marksman",
          "svelte-language-server",
          "json-lsp",
          "pyright",
          "isort",
          "black",
        },
      }
    end
  }
  use { "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "SirVer/ultisnips",
    },
    config = function()
      require("cmp").event:on(
        "confirm_done",
        require("nvim-autopairs.completion.cmp").on_confirm_done()
      )
    end
  }
  -- treesitter
  use { "nvim-treesitter/nvim-treesitter",
    requires = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "andymass/vim-matchup",
    },
    run = ":TSUpdate",
    config = function()
      require "nvim-treesitter.configs".setup {
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
          "sql",
          "toml",
          "yaml",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        autotag = { enable = true },
        context_commentstring = { enable = true },
        matchup = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      }
    end }
  -- statusline
  use { "nvim-lualine/lualine.nvim",
    config = function()
      require "lualine".setup {
        sections = {
          lualine_c = { { 'filename', path = 1 } }
        },
      }
    end }
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
  }
end)
