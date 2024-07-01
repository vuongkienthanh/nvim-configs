return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "andymass/vim-matchup",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
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
                matchup = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            -- method call
                            ["ac"] = "@call.outer",
                            ["ic"] = "@call.inner",
                        },
                    },
                },
            })
        end,
    },
    {
        "andymass/vim-matchup",
        init = function()
            vim.g.matchup_motion_enabled = 1
            -- linewise operation with matchup
            vim.g.matchup_text_obj_enabled = 1
            -- ignore strings & comments
            vim.g.matchup_delim_noskips = 2
        end,
    },
}
