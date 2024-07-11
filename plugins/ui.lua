return {
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
        opts = {
            scope = {
                char = "┠",
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "nightfly",
            },
            sections = {
                lualine_c = { { "filename", path = 1 } },
            },
        },
    },
}
