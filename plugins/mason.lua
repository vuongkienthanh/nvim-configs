return {
    -- auto install with mason tools
    {
        "williamboman/mason.nvim",
        config = true,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- generic
                "taplo",
                "yaml-language-server",
                "json-lsp",
                "marksman",

                -- lua
                "lua-language-server",
                "stylua", -- formatter

                -- web dev
                "html-lsp",
                "css-lsp",
                -- "eslint-lsp",
                "typescript-language-server",
                -- "svelte-language-server",

                -- python
                "pyright",
                "ruff", -- formatter

                -- rust
                "rust-analyzer",
            },
            run_on_start = false,
            integrations = {
                ["mason-lspconfig"] = false,
                ["mason-null-ls"] = false,
                ["mason-nvim-dap"] = false,
            },
        },
    },
}
