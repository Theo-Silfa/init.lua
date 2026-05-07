vim.g.mapleader = ' '

vim.pack.add({
    -- Core UI/Theme
    "https://github.com/raddari/last-color.nvim",
    "https://github.com/rose-pine/neovim",
    "https://github.com/romgrk/barbar.nvim",

    -- LSP & Completion
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/rafamadriz/friendly-snippets",

    -- UI Enhancements
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/SmiteshP/nvim-navic",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/dgagn/diagflow.nvim",

    -- File Navigation
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/dmtrKovalenko/fff.nvim",
    "https://github.com/nvim-mini/mini.pick",
    "https://github.com/nvim-mini/mini.extra",

    -- Editor Utilities
    "https://github.com/mrjones2014/smart-splits.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/axelf4/vim-strip-trailing-whitespace",

    -- AI & Development
    "https://github.com/nickjvandyke/opencode.nvim",
})

-- Load plugin configurations
require("silfa.plugins.colors")
require("silfa.plugins.barbar")
require("silfa.plugins.fff")
require("silfa.plugins.gitsigns")
require("silfa.plugins.lsp")
require("silfa.plugins.lualine")
require("silfa.plugins.mini")
require("silfa.plugins.oil")
require("silfa.plugins.opencode")
require("silfa.plugins.tmux")
require("silfa.plugins.treesitter")
