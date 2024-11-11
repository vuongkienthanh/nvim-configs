return {
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
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        },
        lazy = false,
        branch = "regexp", -- This is the regexp branch, use this for the new version
        config = function()
            require("venv-selector").setup({
                settings = {
                    -- disable all default search, leave only lsp
                    -- I use uv for dev
                    search = {
                        virtualenvs = false,
                        hatch = false,
                        poetry = false,
                        pyenv = false,
                        pipenv = false,
                        anaconda_envs = false,
                        anaconda_base = false,
                        miniconda_envs = false,
                        miniconda_base = false,
                        pipx = false,
                        cwd = false,
                        workspace = {
                            command = "$FD '/bin/python$' $WORKSPACE_PATH --full-path --color never -E /proc -HI -a -L",
                        },
                        file = false,
                    },
                },
            })
        end,
        keys = {
            { "<leader>v", "<cmd>VenvSelect<cr>" },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            -- project lsp settings
            "folke/neoconf.nvim",
        },
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
                    vim.lsp.protocol.make_client_capabilities(),
                    require("cmp_nvim_lsp").default_capabilities()
                ),
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bmap = function(mode, km, ex)
                        vim.api.nvim_buf_set_keymap(args.buf, mode, km, ex, { silent = true })
                    end
                    bmap("n", "gri", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")
                    bmap("n", "grr", ":Telescope lsp_references<CR>")
                    bmap("n", "grm", ":Telescope lsp_implementations<CR>")
                    bmap("n", "<leader>d", ":lua vim.diagnostic.open_float()<CR>")
                    bmap(
                        "n",
                        "<leader>qq",
                        ":lua require('telescope.builtin').diagnostics({bufnr=0, severity_limit=2})<CR>"
                    )
                    bmap("n", "<leader>qa", ":Telescope diagnostics<CR>")
                    -- :h lsp-defaults
                    -- C-w d: open float
                    -- C-]: jump to definition
                    -- C-t: jump back
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
                                "${3rd}/luv/library",
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
}
