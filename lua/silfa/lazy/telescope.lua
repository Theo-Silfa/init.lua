return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            local current_entry = require("oil").get_cursor_entry()
            if (current_entry ~= nil) then
                local full_path = require("oil").get_current_dir(0) .. current_entry.name
                if (current_entry.type == "directory") then
                    builtin.grep_string({ cwd = full_path, search = vim.fn.input("Grep "..current_entry.name.." > ") })
                elseif (current_entry.type == "file") then
                    builtin.grep_string({ search_dirs = {full_path}, search = vim.fn.input("Grep "..current_entry.name.." > ") })
                end
            else
                builtin.grep_string({ search = vim.fn.input("Grep cwd > ") })
            end
        end)
        vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>tt', builtin.diagnostics, {})
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                    },
                },
            },
        })
    end
}
