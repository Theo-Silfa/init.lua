return {
    'nvim-telescope/telescope.nvim',
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
    end
}
