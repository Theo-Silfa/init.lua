require('rose-pine').setup({
    styles = {
        italic = false,
        bold = false,
    },
})
local theme = require('last-color').recall() or 'rose-pine-main'
vim.cmd.colorscheme(theme)
