return {
    'dmtrKovalenko/fff.nvim',
    build = function()
        require("fff.download").download_or_build_binary()
    end,
    opts = { -- (optional)
        prompt = '  ',
        grep = {
            modes = { 'fuzzy', 'plain', 'regex' },
        },
        debug = {
            enabled = true,
            show_scores = true,
        },
    },
    lazy = false,
    keys = {
        {
            "<C-p>",
            function() require('fff').find_files() end,
            desc = 'FFFind files',
        },
        {
            "<leader>pws",
            function() require('fff').live_grep({ query = vim.fn.expand("<cword>") }) end,
            desc = 'Search for <cword>',
        },
        {
            "<leader>pWs",
            function() require('fff').live_grep({ query = vim.fn.expand("<cWORD>") }) end,
            desc = 'Search for <cWORD>',
        },
        {
            "<leader>ps",
            function()
                local oil = require("oil")
                local current_entry = oil.get_cursor_entry()
                if (current_entry == nil) then
                    require('fff').live_grep()
                else
                    require('fff').live_grep({ cwd = oil.get_current_dir(0)})
                end
            end,
            desc = 'Buffer aware search',
        },
    }
}
