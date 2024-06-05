local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

require("lazy").setup({
{
    'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = { 'nvim-lua/plenary.nvim' }
},

{'rose-pine/neovim', name = 'rose-pine'},
{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
{'neovim/nvim-lspconfig'},
{'hrsh7th/cmp-nvim-lsp'},
{'hrsh7th/nvim-cmp'},
{'L3MON4D3/LuaSnip'},

{'williamboman/mason.nvim'},
{'williamboman/mason-lspconfig.nvim'},

{'hrsh7th/cmp-buffer'},
{'hrsh7th/cmp-path'},

{'onsails/lspkind.nvim'},

{'lewis6991/gitsigns.nvim'},
{'ojroques/nvim-osc52'},

{
  'nvim-tree/nvim-tree.lua',
  dependencies = {'nvim-tree/nvim-web-devicons'}
},

{'romgrk/barbar.nvim'},
{'linrongbin16/lsp-progress.nvim'},
{'rebelot/heirline.nvim'},

{
  'SmiteshP/nvim-navic',
  dependencies = {'neovim/nvim-lspconfig'}
},

{'axelf4/vim-strip-trailing-whitespace'},

{'dgagn/diagflow.nvim'},

{
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = { "InsertEnter", "LspAttach" },
      fix_pairs = true,
      config = function()
           require("copilot").setup({
               panel = { enabled = false },
               suggestion = {
                enabled = true,
                auto_trigger = true,
              },
           })
      end,
},

{
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
},
})
