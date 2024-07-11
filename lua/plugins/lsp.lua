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
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Set global defaults for all servers
            lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
                capabilities = vim.tbl_deep_extend(
                    "force",
                    require("cmp_nvim_lsp").default_capabilities(),
                    require("lsp-file-operations").default_capabilities()
                ),
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bmap = function(mode, km, ex)
                        vim.api.nvim_buf_set_keymap(args.buf, mode, km, ex, { silent = true })
                    end
                    bmap(
                        "n",
                        "<leader>qq",
                        ":lua require('telescope.builtin').diagnostics({initial_mode='normal',bufnr=0, severity_bound=2})<CR>"
                    )
                    bmap(
                        "n",
                        "<leader>qa",
                        ":lua require('telescope.builtin').diagnostics({initial_mode='normal'})<CR>"
                    )
                    bmap("n", "gri", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")
                    -- defaults
                    -- C-]: jump to definition
                    -- K: hover
                    -- grn: rename
                    -- gra: code action
                    -- grr: references
                    -- i_C-S: signature help
                end,
            })

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
                require("lspconfig")[lsp].setup({})
            end

            -- rust
            require("lspconfig").rust_analyzer.setup({
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
