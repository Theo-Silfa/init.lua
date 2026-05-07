vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
            if not ev.data.active then vim.cmd.packadd('fff.nvim') end
            require('fff.download').download_or_build_binary()
        end
    end,
})

vim.g.fff = {
    prompt = '  ',
    grep = {
        modes = { 'fuzzy', 'plain', 'regex' },
    },
    debug = {
        enabled = true,
        show_scores = true,
    },
}

vim.keymap.set("n", "<C-p>", function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set("n", "<leader>pws",
    function()
        require('fff').live_grep({
            query = vim.fn.expand("<cword>"),
            grep = {
                modes = { 'plain', 'fuzzy', 'regex' },
            },
        })
    end,
    { desc = 'Search for <cword>' })
vim.keymap.set("n", "<leader>pWs",
    function()
        require('fff').live_grep({
            query = vim.fn.expand("<cWORD>"),
            grep = {
                modes = { 'plain', 'fuzzy', 'regex' },
            },
        })
    end,
    { desc = 'Search for <cWORD>' })
vim.keymap.set("n", "<leader>ps",
    function()
        local oil = require("oil")
        local current_entry = oil.get_cursor_entry()
        if (current_entry == nil) then
            require('fff').live_grep()
        else
            require('fff').live_grep({ cwd = oil.get_current_dir(0) })
        end
    end,
    { desc = 'Buffer aware search' })
