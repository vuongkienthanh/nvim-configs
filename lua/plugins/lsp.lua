return {
    {
        "stevearc/conform.nvim",
        keys = {
            {
                "<leader>ff",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
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
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {
            mappings = {
                extra = false,
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local default_on_attach = function(client, bufnr)
                local bmap = vim.api.nvim_buf_set_keymap
                local opts = { silent = true }
                bmap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
                bmap(
                    bufnr,
                    "n",
                    "<leader>qq",
                    "<cmd>lua vim.diagnostic.setqflist({severity = {min=vim.diagnostic.severity.WARN}})<CR>",
                    opts
                )
                bmap(bufnr, "n", "<leader>qa", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
                bmap(bufnr, "n", "<leader>qz", "<cmd>lua vim.diagnostic.setqlist()<CR>", opts)
                bmap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                bmap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                bmap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
                bmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                bmap(bufnr, "i", "<C-l>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                bmap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
                bmap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
                bmap(
                    bufnr,
                    "n",
                    "<leader>wl",
                    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                    opts
                )
                bmap(bufnr, "n", "<leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
                bmap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
                bmap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
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
            local rust_opts = {
                capabilities = capabilities,
                on_attach = default_on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            features = "all",
                        },
                    },
                },
            }
            require("lspconfig").rust_analyzer.setup(rust_opts)
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
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
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
            })
        end,
    },
}
