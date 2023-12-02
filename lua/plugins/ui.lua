return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        config = function()
            vim.cmd.colorscheme "kanagawa-dragon"
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require "ibl".setup {
                scope = {
                    char = "┠"
                },
            }
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require "lualine".setup {
                options = {
                    theme = "nightfly"
                },
                sections = {
                    lualine_c = {{"filename", path = 1}}
                }
            }
        end
    }
}

