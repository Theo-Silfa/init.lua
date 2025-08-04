function Copy()
    if vim.v.event.operator == 'y' then
        require('osc52').copy_register('+')
    end
end

return {
    'ojroques/nvim-osc52',
    config = function ()
        require('osc52').setup {
            max_length = 0,      -- Maximum length of selection (0 for no limit)
            silent     = true,  -- Disable message on successful Copy
            trim       = false,  -- Trim surrounding whitespaces before Copy
        }

        vim.api.nvim_create_autocmd('TextYankPost', {callback = Copy})
    end
}
