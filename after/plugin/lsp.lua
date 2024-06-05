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

  if client.server_capabilities ~= nil then
      if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
      end
  end
end)

local lua_opts = lsp.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

require("mason").setup()
require('mason-lspconfig').setup({
  ensure_installed = {'clangd', lua_ls},
  handlers = {
    lsp.default_setup,
    clangd = function()
      require('lspconfig').clangd.setup({
        cmd = {
            "/opt/llvm-10/bin/clangd",
            "--offset-encoding=utf-16",
            "--clang-tidy",
        }})
    end,
    lua_ls = function()
        local lua_opts = lsp.nvim_lua_ls()
        require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require('lspkind')

cmp.setup({
    mapping = {
        ['<C-y>']= cmp.mapping.confirm({select = false}),
        ['<C-e>'] = cmp.mapping.abort(),
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

cmp.event:on("menu_opened", function()
  vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on("menu_closed", function()
  vim.b.copilot_suggestion_hidden = false
end)

require('diagflow').setup({
    format = function(diagnostic)
      return diagnostic.message..' [' ..diagnostic.code..']'
    end,
    show_sign = true,
})
