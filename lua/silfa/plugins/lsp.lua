local cmp = require('blink.cmp')
cmp.build():wait(60000)
cmp.setup({
    keymap = {
        preset = 'none',
        ['<C-y>'] = { 'show', 'select_and_accept' },
        ['<C-e>'] = { 'cancel' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-f>'] = { 'snippet_forward', 'fallback' },
        ['<C-b>'] = { 'snippet_backward', 'fallback' },
    },
    completion = { documentation = { auto_show = true } },
    sources = {
        providers = {
            lsp = { fallbacks = {} },
            snippets = {
                opts = {
                    friendly_snippets = true,
                }
            }
        }
    },
    signature = {
        enabled = true,
        window = {
            show_documentation = false,
        }
    }
})

local lsp_attach = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local navic = require('nvim-navic')
    local pickers = require('mini.extra').pickers

    vim.keymap.set('n', 'gr', function() pickers.lsp({ scope = 'references' }) end, opts)
    vim.keymap.set('n', 'gh', '<cmd>LspClangdSwitchSourceHeader<cr>', opts)
    vim.keymap.set('n', 'gf', function() pickers.lsp({ scope = 'document_symbol' }) end, opts)
    vim.keymap.set('n', 'gi', function() pickers.lsp({ scope = 'implementation' }) end, opts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', function() pickers.lsp({ scope = 'definition' }) end, opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', '<leader>tt', function() pickers.diagnostic() end, {})

    if client and client.server_capabilities.documentSymbolProvider then
        navic.attach(client, args.buf)
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
        vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

        vim.keymap.set(
            'i',
            '<A-l>',
            vim.lsp.inline_completion.get,
            { desc = 'LSP: accept inline completion', buffer = bufnr }
        )
        vim.keymap.set(
            'i',
            '<M-]>',
            vim.lsp.inline_completion.select,
            { desc = 'LSP: switch inline completion', buffer = bufnr }
        )
    end
end
vim.api.nvim_create_autocmd('LspAttach', { callback = lsp_attach });

vim.lsp.config('*', { capabilities = cmp.get_lsp_capabilities() })
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("copilot")

require('diagflow').setup({
    format = function(diagnostic)
        if (diagnostic.code == nil) then
            return diagnostic.message
        end
        return diagnostic.message .. ' [' .. diagnostic.code .. ']'
    end,
    show_sign = true,
})
