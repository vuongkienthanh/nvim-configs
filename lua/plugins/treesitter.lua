return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                init = function()
                    vim.g.skip_ts_context_commentstring_module = true
                end,
                config = function()
                    require("ts_context_commentstring").setup {
                        enable_autocmd = false
                    }
                end
            },
            {
                "andymass/vim-matchup",
                init = function()
                    vim.g.matchup_motion_enabled = 0
                    vim.g.matchup_text_obj_enabled = 0
                end
            }
        },
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup(
                {
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
                        "yaml"
                    },
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false
                    },
                    matchup = {enable = true},
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = "gnn",
                            node_incremental = "grn",
                            scope_incremental = "grc",
                            node_decremental = "grm"
                        }
                    }
                }
            )
        end
    }
}

