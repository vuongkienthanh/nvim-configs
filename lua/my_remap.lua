vim.g.mapleader = ','
local map = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true }

local servers = { 'pyright', 'rust_analyzer'}

map('n', '<F2>', ':NvimTreeToggle<CR>', opts)

map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
local on_attach = function(client, bufnr)
  local bmap = vim.api.nvim_buf_set_keymap
  bmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  bmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  bmap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  bmap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  bmap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  bmap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  bmap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  bmap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  bmap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  bmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  bmap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local cmp = require("cmp")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
    { name = 'path' },
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
    ['<C-Space>'] = cmp.mapping.complete(),
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


-- quickfix
map('n', '<F3>', ':ccl<CR>:lcl<CR>', opts)
map('n', ']q', ':cnext<CR>zzzv', opts)
map('n', '[q', ':cprev<CR>zzzv', opts)
-- buffers
map('n', ']b', ':bn<CR>', opts)
map('n', '[b', ':bp<CR>', opts)
-- tabs
map('n', ']t', ':tabnext<CR>', opts)
map('n', '[t', ':tabprev<CR>', opts)
-- add blank line
map('n', ']<space>', 'mxo<ESC>0D`x', opts)
map('n', '[<space>', 'mxO<ESC>0D`x', opts)
-- move line
map('v', '<C-j>', ":m '>+1<CR>gv=gv", opts)
map('v', '<C-k>', ":m '<-2<CR>gv=gv", opts)
-- better default keymaps
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)
map('n', 'zz', 'zzzH', opts)
map('n', '<C-L>', ':<C-U>nohls<CR><C-L>', opts)
map('n', 'J', 'mxJ`x', opts)
-- copy visual selected to clipboard
map('v', '<C-Y>', '"+y', opts)
-- Undo break point
map('i', ',', ',<C-G>u', opts)
map('i', ';', ';<C-G>u', opts)
map('i', '.', '.<C-G>u', opts)
map('i', '!', '!<C-G>u', opts)
map('i', '?', '?<C-G>u', opts)
map('i', '<CR>', '<CR><C-G>u', opts)
