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
                    -- generic
                    "taplo",
                    "yaml-language-server",
                    "json-lsp",
                    "marksman",

                    -- lua
                    -- "lua-language-server",
                    "stylua", -- formatter

                    -- web deb
                    -- "html-lsp",
                    -- "css-lsp",
                    -- "eslint-lsp",
                    -- "typescript-language-server",
                    -- "svelte-language-server",

                    -- python
                    "pyright", -- type checker
                    "ruff", -- formatter

                    -- rust
                    "rust-analyzer",
                },
                integrations = {
                    ["mason-lspconfig"] = false,
                    ["mason-null-ls"] = false,
                    ["mason-nvim-dap"] = false,
                },
            })
        end,
    },
}
