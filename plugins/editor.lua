return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        keys = {
            { "<leader><tab>", ":Neotree toggle<CR>" },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { "<leader>fp", ":Telescope builtin<CR>" },
            { "<leader>fg", ":Telescope live_grep<CR>" },
            { "<leader>fb", ":Telescope buffers<CR>" },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        n = {
                            ["q"] = require("telescope.actions").close,
                        },
                    },
                    initial_mode = "normal",
                    scroll_strategy = "limit",
                    preview = {
                        filesize_limit = 0.1, -- MB
                    },
                },
                pickers = {
                    live_grep = {
                        initial_mode = "insert",
                    },
                },
            })
            require("telescope").load_extension("fzf")
        end,
    },
}
