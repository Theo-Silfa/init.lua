local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})

  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references show_line=false<cr>', {buffer = true})
  vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', {buffer = true})
  vim.keymap.set('n', 'gf', '<cmd>Telescope lsp_document_symbols ignore_symbols=variable symbol_width=100<cr>', {buffer = true})
  vim.keymap.set('n', 'gi', '<cmd> Telescope lsp_implementations fname_width=100<cr>', {buffer = true})
end)

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

lsp.ensure_installed({
  'clangd',
  'lua_ls'
})

lsp.preset({
  manage_nvim_cmp = {
    set_source = 'recommended', 
  }
})

local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  },
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
})

lsp.setup()
