return {
    {
        "pteroctopus/faster.nvim",
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false,
        config = function()
            vim.keymap.set("n", "<leader><tab>", ":Neotree toggle<CR>")
        end,
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
                    builtin = {
                        previewer = false,
                    },
                },
            })
            require("telescope").load_extension("fzf")
        end,
    },
}
