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
        headers = {
            user = '👤 You: ',
            assistant = '🤖 Copilot: ',
            tool = '🔧 Tool: ',
        },
        show_help = false,              -- Disable help text
        auto_insert_mode = true,        -- Enter insert mode when opening
    },
    config = function(_, opts)
        require("CopilotChat").setup(opts)

        vim.keymap.set('n', '<leader>cc', '<cmd>CopilotChatToggle<cr>', { desc = 'Open Copilot Chat' })
        vim.keymap.set('i', '<C-c>', '<cmd>CopilotChatToggle<cr>', { desc = 'Open Copilot Chat in Insert Mode' })

        vim.keymap.set('v', '<leader>cs', function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
                require("CopilotChat").ask(input, {
                    selection = require("CopilotChat.select").visual
                })
            end
        end, { desc = "CopilotChat - Quick chat (selection)" })

        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = 'copilot-*',
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number = false
                vim.opt_local.conceallevel = 0
            end
        })
    end,
}
