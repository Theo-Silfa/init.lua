local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})

  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = true})
  vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', {buffer = true})
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
