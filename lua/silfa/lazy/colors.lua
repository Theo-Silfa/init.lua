return {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function ()
        require('rose-pine').setup({
            styles = {
                italic = false,
                bold = false,
            },
            highlight_groups = {
                TelescopeBorder = { fg = "highlight_high", bg = "none" },
                TelescopeNormal = { bg = "none" },
                TelescopePromptNormal = { bg = "base" },
                TelescopeResultsNormal = { fg = "subtle", bg = "none" },
                TelescopeSelection = { fg = "text", bg = "base" },
            },
        })
        vim.cmd.colorscheme("rose-pine")
    end
}
