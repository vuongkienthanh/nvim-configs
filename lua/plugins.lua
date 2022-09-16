require("packer").init({
  git = {
    clone_timeout = false,
  },
})
require("packer").startup(function()
  use { "wbthomason/packer.nvim" }
  use { "kyazdani42/nvim-web-devicons" }
  use { "nvim-lua/plenary.nvim" }
  use { "MunifTanjim/nui.nvim" }
  use { "catppuccin/nvim",
    as = "catppuccin",
    run = ":CatppuccinCompile",
    config = function()
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
      require("catppuccin").setup {
        compile = {
          enabled = true
        },
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = { "italic" },
        },
        nvimtree = { enabled = false },
        neotree = { enabled = false },
        indent_blankline = { enabled = false },
        gitsigns = { enabled = false },
      }
      vim.cmd [[colorscheme catppuccin]]
    end }
  use { "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup() end }
  use { "lukas-reineke/indent-blankline.nvim",
    config = function() require "indent_blankline".setup() end }
  use { "numToStr/Comment.nvim",
    config = function() require "Comment".setup {
        mapping = {
          extra = false
        }
      }
    end }
  use { "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {
        check_ts = true,
      }
    end }
  use { "norcalli/nvim-colorizer.lua",
    config = function() require "colorizer".setup() end }
  use { "uga-rosa/ccc.nvim" }
  use { "akinsho/toggleterm.nvim",
    config = function() require("toggleterm").setup {
        open_mapping = [[<c-\>]],
        direction = "horizontal",
      }
    end }

  -- explorer
  use { "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require("neo-tree").setup {
        enable_git_status = false,
      }
    end
  }
  -- lsp
  use { "neovim/nvim-lspconfig" }
  use { "onsails/lspkind-nvim" }
  use { "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "SirVer/ultisnips",
      config = function()
        require("cmp").event:on(
          "confirm_done",
          require("nvim-autopairs.completion.cmp").on_confirm_done()
        )
        vim.fn.system("mkdir", "-p", "~/.config/nvim/UltiSnips")
      end
    } }
  use {
    "simrat39/rust-tools.nvim",
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function() require("null-ls").setup {
        sources = {
          require("null-ls").builtins.formatting.black,
        },
      }
    end,
  }
  -- treesitter
  use { "nvim-treesitter/nvim-treesitter",
    requires = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "andymass/vim-matchup",
    },
    run = ":TSUpdate",
    config = function() require "nvim-treesitter.configs".setup {
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
        },
        highlight = { enable = true },
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
    config = function() require "lualine".setup {
        extensions = {
          "toggleterm",
          "neo-tree",
        }
      }
    end }
  use { "nvim-telescope/telescope.nvim" }
end)


-- Create an autocmd User PackerCompileDone to update it every time packer is compiled
vim.api.nvim_create_autocmd("User", {
  pattern = "PackerCompileDone",
  callback = function()
    vim.cmd "CatppuccinCompile"
    vim.defer_fn(function()
      vim.cmd "colorscheme catppuccin"
    end, 0) -- Defered for live reloading
  end
})
