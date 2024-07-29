return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdateSync",
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
                    "jsonc",
                    "svelte",
                    "javascript",
                    "typescript",
                    "html",
                    "css",
                    "markdown",
                    "sql",
                    "toml",
                    "yaml",
                    "vimdoc",
                },
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        -- check parser
                        local disable_parsers = { "vimdoc", "csv" }
                        for _, v in pairs(disable_parsers) do
                            if v == lang then
                                return true
                            end
                        end
                        -- check filesize
                        local max_filesize = 100 * 1024
                        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                matchup = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            -- def, fn, function
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            -- class, impl, enum, struct
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            -- method call
                            ["am"] = "@call.outer",
                            ["im"] = "@call.inner",
                            -- conditional
                            ["ao"] = "@conditional.outer",
                            ["io"] = "@conditional.inner",
                            -- loop
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            -- block
                            ["ab"] = "@block.outer",
                            ["ib"] = "@block.inner",
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
