local opts = { silent = true }

return {
    {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "ggandor/leap.nvim",
        lazy = false,
        config = function()
            vim.keymap.set("n", "<leader>s", "<Plug>(leap)")
        end,
    },
    {
        "uga-rosa/ccc.nvim",
        config = function()
            local ccc = require("ccc")
            ccc.setup({
                inputs = {
                    ccc.input.rgb,
                },
                outputs = {
                    ccc.output.hex,
                    ccc.output.css_rgb,
                    ccc.output.float,
                    {
                        name = "RGB tuple",
                        str = function(RGB, A)
                            local R, G, B = unpack(RGB)
                            if A then
                                return ("(%d, %d, %d, %d)"):format(R, G, B, A)
                            else
                                return ("(%d, %d, %d)"):format(R, G, B)
                            end
                        end,
                    },
                },
            })
        end,
        keys = {
            { "<C-j>", ":CccPick<CR>", opts },
            { "<C-j>", "<Plug>(ccc-insert)", mode = "i", opts },
        },
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("Comment").setup({
                mappings = {
                    extra = false,
                },
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        keys = {
            {
                "<leader>ff",
                function()
                    require("conform").format({ lsp_format = "fallback" })
                end,
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_fix", "ruff_format" },
            },
        },
    },
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        },
        lazy = false,
        branch = "regexp", -- This is the regexp branch, use this for the new version
        config = function()
            require("venv-selector").setup({
                settings = {
                    -- disable all default search, leave only lsp
                    -- I use uv for dev
                    search = {
                        virtualenvs = false,
                        hatch = false,
                        poetry = false,
                        pyenv = false,
                        pipenv = false,
                        anaconda_envs = false,
                        anaconda_base = false,
                        miniconda_envs = false,
                        miniconda_base = false,
                        pipx = false,
                        cwd = false,
                        file = false,
                    },
                },
            })
        end,
        keys = {
            { "<leader>v", "<cmd>VenvSelect<cr>" },
        },
    },
    {
        "neovim/nvim-lspconfig",
    },
}
