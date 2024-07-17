return {
    -- auto install with mason tools
    {
        "williamboman/mason.nvim",
        config = true,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "rust-analyzer",
                    "taplo",
                    "yaml-language-server",
                    "lua-language-server",
                    "html-lsp",
                    "css-lsp",
                    "eslint-lsp",
                    "typescript-language-server",
                    "marksman",
                    "svelte-language-server",
                    "json-lsp",
                    "pyright",
                    "ruff",
                    "stylua",
                },
            })
        end,
    },
}
