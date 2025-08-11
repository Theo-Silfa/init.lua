return {
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp'
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr }
                local navic = require('nvim-navic')

                vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references show_line=false<cr>', opts)
                vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', opts)
                vim.keymap.set('n', 'gf',
                    '<cmd>Telescope lsp_document_symbols ignore_symbols=variable symbol_width=100<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations fname_width=100<cr>', opts)

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end

            local lsp_setup = function(server, opts)
                vim.lsp.config(server, opts)
                vim.lsp.enable(server)
            end

            lsp_setup("clangd", {
                on_attach = lsp_attach,
                cmd = { "clangd", "--offset-encoding=utf-16", "--clang-tidy"},
                capabilities = capabilities
            })
            lsp_setup("lua_ls", {on_attach = lsp_attach, capabilities = capabilities})
            lsp_setup("pyright", {on_attach = lsp_attach, capabilities = capabilities})
        end
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'rafamadriz/friendly-snippets',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            local tab_complete = function(select_opts)
                return cmp.mapping(function(fallback)
                    local col = vim.fn.col('.') - 1

                    if cmp.visible() then
                        cmp.select_next_item(select_opts)
                    elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, {'i', 's'})
            end

            local luasnip_jump_forward = function()
                return cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, {'i', 's'})
            end

            local luasnip_jump_backward = function()
                return cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'})
            end

            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip').filetype_extend("cpp", {"cppdoc"})

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<Tab>'] = tab_complete(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    ['<Down>'] = cmp.mapping(function(fallback)
                        cmp.close()
                        fallback()
                    end, { "i" }),
                    ['<Up>'] = cmp.mapping(function(fallback)
                        cmp.close()
                        fallback()
                    end, { "i" }),
                    ['<C-f>'] = luasnip_jump_forward(),
                    ['<C-b>'] = luasnip_jump_backward(),
                }),
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                sources = {
                    { name = 'nvim_lsp'},
                    { name = 'buffer'},
                    { name = 'path'},
                    { name = 'luasnip'},
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })
        end
    },
    {
        'dgagn/diagflow.nvim',
        config = function ()
            require('diagflow').setup({
                format = function(diagnostic)
                    if (diagnostic.code == nil) then
                        return diagnostic.message
                    end
                    return diagnostic.message .. ' [' .. diagnostic.code .. ']'
                end,
                show_sign = true,
            })
        end
    },
}
