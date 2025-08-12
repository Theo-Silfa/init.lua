return {
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'saghen/blink.cmp'
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()

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
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'none',
                ['<C-y>'] = { 'select_and_accept' },
                ['<C-e>'] = { 'cancel' },
                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<C-f>'] = { 'snippet_forward', 'fallback' },
                ['<C-b>'] = { 'snippet_backward', 'fallback' },
            },
            completion = { documentation = { auto_show = true } },
            sources = {
                providers = {
                    lsp = { fallbacks = {} }
                }
            },
        },
        --vim.fn.stdpath('data')
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
