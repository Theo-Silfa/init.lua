local ts = require('nvim-treesitter')

ts.install { 'cpp', 'bash', 'python', 'lua' }
vim.api.nvim_create_autocmd('PackChanged', { callback = function() ts.update() end })
vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        local available_langs = ts.get_available()
        local is_available = vim.tbl_contains(available_langs, lang)
        if is_available then
            local installed_langs = ts.get_installed()
            local installed = vim.tbl_contains(installed_langs, lang)
            if not installed then
                ts.install(lang):wait()
            end
            vim.treesitter.start()
            ts.indentexpr()
        end
    end,
})
