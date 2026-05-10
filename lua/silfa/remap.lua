-- open file EXplorer
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")
vim.keymap.set("n", "<leader>pV", function()
    require("oil").open(vim.loop.cwd())
end)

-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- half page jump and stay at the center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- half page search and stay at the center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- replace the current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--apply fix from lsp
local opts = { noremap = true, silent = true }
local function quickfix()
    vim.lsp.buf.code_action({
        apply = true
    })
end
vim.keymap.set('n', '<leader>qf', quickfix, opts)

--diagnostic navigation
vim.keymap.set('n', ']t', function()
    vim.diagnostic.jump({ count=1, float = false })
end)
vim.keymap.set('n', '[t', function()
    vim.diagnostic.jump({ count=-1, float = false })
end)

-- yank filepath and linenumber to system clipboard
vim.keymap.set('n', '<leader>yp', function()
    local filepath = vim.fn.expand('%')
    local linenumber = vim.fn.line('.')
    local fullpath = filepath .. ':' .. linenumber
    vim.fn.setreg('+', fullpath)
end)

-- toggle between light and dark theme
vim.keymap.set('n', '<leader>tl', function()
    if vim.o.background == 'dark' then
        vim.cmd.colorscheme("rose-pine-dawn")
    else
        vim.cmd.colorscheme("rose-pine-main")
    end
end)

-- tmux-like splits
vim.keymap.set('n', '<leader>%', '<CMD>vsplit<CR>', { desc = "Vertical split" })
vim.keymap.set('n', '<leader>"', '<CMD>split<CR>', { desc = "Horizontal split" })
vim.keymap.set('n', '<leader>x', '<CMD>close<CR>', { desc = "Close pane" })

-- lazy shift fix
vim.api.nvim_create_user_command('W', 'w', { desc = "Add map :W to :w" })

--git blame toggle
vim.keymap.set('n', '<leader>gb', function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)

        if buf and vim.bo[buf].filetype == 'gitsigns-blame' then
            if not pcall(vim.api.nvim_win_close, win, true) then
                pcall(vim.api.nvim_buf_delete, buf, {})
            end

            return
        end
    end

    local cur_win = vim.api.nvim_get_current_win()
    require('gitsigns').blame()

    -- Switch focus back to the original window
    if vim.api.nvim_get_current_win() ~= cur_win then
        vim.api.nvim_set_current_win(cur_win)
    end
end, { desc = "Toggle git blame" })
