return {
    {
        "stevearc/conform.nvim",
        keys = {
            {
                "<leader>ff",
                function()
                    require("conform").format({ lsp_format = "fallback" })
                end,
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_fix", "ruff_format" },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local default_on_attach = function(client, bufnr)
                local bmap = function(mode, km, ex)
                    vim.api.nvim_buf_set_keymap(bufnr, mode, km, ex, { silent = true })
                end
                -- diagnostic
                bmap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
                bmap(
                    "n",
                    "<leader>qq",
                    ":lua vim.diagnostic.setqflist({severity = {min=vim.diagnostic.severity.WARN}})<CR>"
                )
                bmap("n", "<leader>qa", "<cmd>lua vim.diagnostic.setloclist()<CR>")
                bmap("n", "<leader>qz", "<cmd>lua vim.diagnostic.setqflist()<CR>")
                -- workspace
                -- bmap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
                -- bmap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
                -- bmap( "n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
                bmap("n", "<leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
                -- misc
                bmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
                bmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
                bmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
                bmap("i", "<C-l>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
                bmap("n", "<leader>il", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")
                bmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
                bmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local servers = {
                "svelte",
                "taplo",
                "yamlls",
                "jsonls",
                "cssls",
                "eslint",
                "html",
                "lua_ls",
                "pyright",
            }

            for _, lsp in pairs(servers) do
                require("lspconfig")[lsp].setup({
                    capabilities = capabilities,
                    on_attach = default_on_attach,
                })
            end
            -- rust
            require("lspconfig").rust_analyzer.setup({
                capabilities = capabilities,
                on_attach = default_on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            features = "all",
                        },
                    },
                },
            })
        end,
    },
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
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "nvim-autopairs",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "luasnip" },
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-f>"] = cmp.mapping.confirm({ select = false }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
            })
        end,
    },
}
