return {
    {
        "pteroctopus/faster.nvim",
    },
    {
        "fnune/recall.nvim",
        version = "*",
        config = function()
            local recall = require("recall")
            recall.setup({})
            vim.keymap.set("n", "<leader>mm", recall.toggle, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>mc", recall.clear, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ml", ":Telescope recall<CR>", { noremap = true, silent = true })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        lazy = false,
        config = function()
            vim.keymap.set("n", "<leader><tab>", ":Neotree toggle<CR>")
            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                    },
                },
            })
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
