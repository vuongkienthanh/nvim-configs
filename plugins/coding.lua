local opts = { silent = true }

return {
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>s",
                function()
                    print("leaping...")
                    local current_window = vim.fn.win_getid()
                    require("leap").leap({ target_windows = { current_window } })
                    print(" ")
                end,
                opts,
            },
        },
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
                        name = "RGB args",
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
}
