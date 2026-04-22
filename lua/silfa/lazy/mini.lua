return {
    'nvim-mini/mini.pick',
    version = '*',
    dependencies = { 'nvim-mini/mini.extra', version = '*' },
    config = function()
        -- Centered on screen
        local win_config = function()
            local height = math.floor(0.618 * vim.o.lines)
            local width = math.floor(0.618 * vim.o.columns)
            return {
                anchor = 'NW',
                height = height,
                width = width,
                row = math.floor(0.5 * (vim.o.lines - height)),
                col = math.floor(0.5 * (vim.o.columns - width)),
                border = 'double',
            }
        end

        require('mini.pick').setup({
            window = {
                config = win_config,
            },
            options = {
                use_cache = true,
            },
        })
        require('mini.extra').setup()

        local builtin = require('mini.pick').builtin
        vim.keymap.set('n', '<leader>vh', builtin.help, { desc = 'Search help documentation' })
        vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Switch between open buffers' })
        vim.keymap.set('n', '<leader>r', builtin.resume, { desc = 'Resume last picker session' })

        --fix invisible selection
        local palette = require('rose-pine.palette')
        vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", {fg = palette.text, bg = palette.highlight_med})
    end
}
