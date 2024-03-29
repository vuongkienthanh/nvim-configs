vim.g.mapleader = ' '
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local servers = {
  'svelte',
  'taplo',
  'yamlls',
  'jsonls',
  'cssls',
  'eslint',
  'html',
  'lua_ls',
}

map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist({severity = {min=vim.diagnostic.severity.WARN}})<CR>', opts)
map('n', '<leader>a', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local default_on_attach = function(client, bufnr)
  local bmap = vim.api.nvim_buf_set_keymap
  bmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  bmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  bmap(bufnr, 'i', '<C-l>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  bmap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  bmap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  bmap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  bmap(bufnr, 'n', '<leader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  bmap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  bmap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  bmap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  bmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  bmap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format{async=true}<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = default_on_attach,
  }
end

-- python
require('lspconfig').pyright.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local bmap = vim.api.nvim_buf_set_keymap
    bmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    bmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    bmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    bmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    bmap(bufnr, 'i', '<C-l>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    bmap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    bmap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    bmap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    bmap(bufnr, 'n', '<leader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    bmap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    bmap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    bmap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    bmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    bmap(bufnr, 'n', '<leader>f', '<cmd>Format<CR>', opts)
    bmap(bufnr, 'n', '<leader>i', '<cmd>wa<CR><cmd>!isort --profile black . && black .<CR>', opts)
  end,
}
-- rust
local rust_opts = {
  tools = {
    executor = require("rust-tools.executors").quickfix,
  },
  server = {
    capabilities = capabilities,
    on_attach = default_on_attach,
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          features = 'all'
        }
      }
    }
  },
}
require('rust-tools').setup(rust_opts)

local cmp = require("cmp")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lsp_signature_help' },
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-o>'] = cmp.mapping.close(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    ["<Tab>"] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
      end,
      { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    ),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.jump_backwards(fallback)
      end,
      { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    ),
  },
  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
    })
  }
}

-- explorer
map('n', '<leader><tab>', ':Neotree toggle<CR>', opts)
map('n', '<leader>`', ':Neotree buffers toggle<CR>', opts)
local builtin = require('telescope.builtin')
map('n', '<leader>fg', builtin.live_grep, opts)
-- windows
map('n', '<leader>j', '<C-W><C-j>', opts)
map('n', '<leader>k', '<C-W><C-k>', opts)
map('n', '<leader>h', '<C-W><C-h>', opts)
map('n', '<leader>l', '<C-W><C-l>', opts)
-- color picker
map('n', '<C-j>', ':CccPick<CR>', opts)
map('i', '<C-j>', '<Plug>(ccc-insert)', opts)
-- leap.nvim
map('n', '<leader>s', '<Plug>(leap-forward-to)', opts)
map('n', '<leader>d', '<Plug>(leap-backward-to)', opts)
-- move line
map('v', '<C-j>', ":m '>+1<CR>gv", opts)
map('v', '<C-k>', ":m '<-2<CR>gv", opts)
-- better default keymaps
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)
map('n', 'zz', 'zzzH', opts)
map('n', '<C-l>', ':ccl<CR>:lcl<CR>:nohls<CR><C-l>', opts)
map('n', 'J', 'mxJ`x', opts)
-- copy visual selected to clipboard
map('v', '<C-Y>', '"+y', opts)
-- paste last yanked
map('n', '<C-P>', '"0p', opts)
-- Undo break point
map('i', ',', ',<C-G>u', opts)
map('i', ';', ';<C-G>u', opts)
map('i', ':', ':<C-G>u', opts)
map('i', '.', '.<C-G>u', opts)
map('i', '!', '!<C-G>u', opts)
map('i', '?', '?<C-G>u', opts)
map('i', '<CR>', '<CR><C-G>u', opts)
-- add char at the end
map('n', ';;', 'mxA;<ESC>`x', opts)
map('n', ',,', 'mxA,<ESC>`x', opts)
