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
    -- project lsp settings
    { "folke/neoconf.nvim" },
    -- generic formatter, replace lsp_format
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
                ["*"] = { "squeeze_blanks" },
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
            require("neoconf").setup({
                import = {
                    vscode = false,
                    coc = false,
                    nlsp = false,
                },
                live_reload = false,
            })

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
                    bmap("n", "gri", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")
                    bmap("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>")
                    -- defaults
                    -- C-]: jump to definition
                    -- C-T: jump back
                    -- K: hover
                    -- grn: rename
                    -- gra: code action
                    -- grr: references
                    -- i_C-s: signature help
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
                "pyright",
                "rust_analyzer",
            }

            for _, lsp in pairs(servers) do
                require("lspconfig")[lsp].setup({})
            end

            -- lua_ls is mainly for neovim
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
            require("lspconfig").lua_ls.setup({
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                        return
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            version = "LuaJIT",
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                            },
                        },
                    })
                end,
                settings = {
                    Lua = {},
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
