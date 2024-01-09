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
local lspkind = require('lspkind')

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        ['<Down>'] = cmp.mapping(function(fallback)
                cmp.close()
                fallback()
                end, { "i" }),
        ['<Up>'] = cmp.mapping(function(fallback)
                cmp.close()
                fallback()
                end, { "i" }),
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    sources = {
        {name = 'nvim_lsp', group_index = 1 },
        {name = 'buffer', group_index = 1 },
        {name = 'path', group_index = 2 },
    },
    formatting = {
        fields = {'abbr', 'kind', 'menu'},
        format = require('lspkind').cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
            symbol_map = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
            },
        })
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

require('diagflow').setup({
    format = function(diagnostic)
      return diagnostic.message..' [' ..diagnostic.code..']'
    end,
    show_sign = true,
})
