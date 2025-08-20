return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
        model = 'gpt-4.1',              -- AI model to use
        temperature = 0.1,              -- Lower = focused, higher = creative
        window = {
            layout = 'vertical',        -- 'vertical', 'horizontal', 'float'
            width = 0.5,                -- 50% of screen width
        },
        auto_insert_mode = true,     -- Enter insert mode when opening
        headers = {
            user = '👤 You: ',
            assistant = '🤖 Copilot: ',
            tool = '🔧 Tool: ',
        },
        show_help = false,              -- Disable help text
        mappings = {
            complete = { normal = '', insert = '<C-y>' },
            close = { normal = 'q', insert = '<C-c>' },
            reset = { normal = 'cr', insert = '' },
            submit_prompt = { normal = '<CR>', insert = '<C-s>' },
            toggle_sticky = { normal = '', insert = '' },
            accept_diff = { normal = '<A-l>', insert = '' },
            jump_to_diff = { normal = 'gj', insert = '' },
            quickfix_diffs = { normal = 'gqd', insert = '' },
            yank_diff = { normal = 'gy', insert = '', register = '+' },
            show_diff = { normal = 'gd', insert = '' },
            show_info = { normal = '', insert = '' },
            show_help = { normal = '', insert = '' },
        }
    },
    config = function(_, opts)
        require("CopilotChat").setup(opts)

        vim.keymap.set({'n', 'v'}, '<leader>cc', '<cmd>CopilotChatToggle<cr>', { desc = 'Open Copilot Chat' })

        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = 'copilot-*',
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number = false
                vim.opt_local.conceallevel = 0
                vim.opt_local.fillchars:append({ eob = " " })
            end
        })
    end,
}
