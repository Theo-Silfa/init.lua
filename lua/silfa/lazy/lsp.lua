return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()
            local cmp_format = require('lsp-zero').cmp_format({details = true})

            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip').filetype_extend("cpp", {"cppdoc"})

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<Tab>'] = cmp_action.tab_complete(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    ['<Down>'] = cmp.mapping(function(fallback)
                        cmp.close()
                        fallback()
                    end, { "i" }),
                    ['<Up>'] = cmp.mapping(function(fallback)
                        cmp.close()
                        fallback()
                    end, { "i" }),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
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
                formatting = cmp_format,
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
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            {'rafamadriz/friendly-snippets'},
            {'saadparwaiz1/cmp_luasnip'},
        },
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr }

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
                    require('nvim-navic').attach(client, bufnr)
                end
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            })

            require('mason-lspconfig').setup({
                ensure_installed = { "clangd", "lua_ls", "pyright" },
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    clangd = function()
                        require('lspconfig').clangd.setup({
                            cmd = { "clangd", "--offset-encoding=utf-16", "--clang-tidy"
                            }
                        })
                    end,
                }
            })
        end
    },
    {
        'SmiteshP/nvim-navic',
        dependencies = { 'neovim/nvim-lspconfig' }
    },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'dgagn/diagflow.nvim' },
}
