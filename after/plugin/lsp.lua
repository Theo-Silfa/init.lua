local lsp = require('lsp-zero').preset({
    name = 'recommended',
})
local navic = require("nvim-navic")

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})

  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references show_line=false<cr>', {buffer = true})
  vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', {buffer = true})
  vim.keymap.set('n', 'gf', '<cmd>Telescope lsp_document_symbols ignore_symbols=variable symbol_width=100<cr>', {buffer = true})
  vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations fname_width=100<cr>', {buffer = true})

  if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
  end
end)

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

lsp.ensure_installed({
  'clangd',
  'lua_ls'
})

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
})

require('diagflow').setup({
    format = function(diagnostic)
      return diagnostic.message..' [' ..diagnostic.code..']'
    end,
    show_sign = true,
})
