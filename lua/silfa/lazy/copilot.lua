return {
    "zbirenbaum/copilot.lua",
    commit = "30321e33b03cb924fdcd6a806a0dc6fa0b0eafb9",
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
}
