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
  use { "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {
        check_ts = true,
      }
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
    branch = "v2.x",
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require("neo-tree").setup()
    end
  }

  -- lsp
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "onsails/lspkind-nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "simrat39/rust-tools.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.black,
        },
      }
    end
  }
  use {
    "williamboman/mason.nvim",
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "jayp0521/mason-null-ls.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "rust_analyzer",
          "pyright",
          "taplo",
          "yamlls",
          "lua_ls",
          "html",
          "cssls",
          "eslint",
          "tsserver",
          "marksman",
          "svelte",
        },
      }
      require("mason-null-ls").setup {
        ensure_installed = { "black" },
        automatic_installation = false,
        automatic_setup = false,
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
        extensions = {
          "neo-tree",
        }
      }
    end }
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
  }
end)
