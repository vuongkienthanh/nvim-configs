local opts = { silent = true }

return {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "MunifTanjim/nui.nvim" },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        keys = {
            { "<leader><tab>", ":Neotree toggle<CR>", opts },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { "<leader>fg", ":Telescope live_grep<CR>", opts },
            { "<leader>fb", ":Telescope buffers<CR>", opts },
        },
        config = function()
            require("telescope").setup()
            require("telescope").load_extension("fzf")
        end,
    },
}
