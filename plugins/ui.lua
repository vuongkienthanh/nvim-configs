return {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "MunifTanjim/nui.nvim" },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        config = function()
            vim.cmd.colorscheme("kanagawa-dragon")
            require("kanagawa").setup({ compile = true })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = false,
        opts = {
            scope = {
                char = "┠",
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "jellybeans",
            },
            sections = {
                lualine_c = { { "filename", path = 1 }, "filesize" },
            },
        },
    },
}
