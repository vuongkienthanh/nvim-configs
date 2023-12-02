local opts = { silent = true }

return {
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>s",
                function()
                    local current_window = vim.fn.win_getid()
                    require("leap").leap({ target_windows = { current_window } })
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
                    {
                        name = "RGB args",
                        str = function(RGB)
                            return ("(%d, %d, %d)"):format(table.unpack(RGB))
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
}
