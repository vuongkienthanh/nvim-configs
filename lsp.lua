local servers = {
    -- generic
    "taplo",
    "yamlls",
    "jsonls",
    "marksman",

    -- lua
    "lua_ls",

    -- web dev
    "html",
    "cssls",
    -- "eslint",
    "ts_ls",
    -- "svelte",

    -- python
    "pyright",

    -- rust
    "rust_analyzer",
}

for _, lsp in pairs(servers) do
    vim.lsp.enable(lsp)
end
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
vim.lsp.config("lua_ls", {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                },
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            },
        })
    end,
    settings = {
        Lua = {},
    },
})
vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                features = "all",
            },
            check = {
                command = "clippy",
            },
        },
    },
})
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bmap = function(mode, km, ex)
            vim.api.nvim_buf_set_keymap(args.buf, mode, km, ex, { silent = true })
        end
        bmap("n", "grr", ":Telescope lsp_references<CR>")
        bmap("n", "grm", ":Telescope lsp_implementations<CR>")
        bmap("n", "<leader>d", ":lua vim.diagnostic.open_float()<CR>")
        bmap("n", "<leader>i", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")
        bmap("n", "<leader>qq", ":lua require('telescope.builtin').diagnostics({bufnr=0, severity_limit=2})<CR>")
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
