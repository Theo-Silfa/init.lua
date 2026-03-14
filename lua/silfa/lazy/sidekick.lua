return {
    "folke/sidekick.nvim",
    event = "VeryLazy",
    dependencies = {
        "zbirenbaum/copilot.lua",
    },
    opts = {
        nes = { enabled = false },
        -- add any options here
        cli = {
            mux = {
                backend = "tmux",
                enabled = true,
            },
        },
    },
    keys = {
        {
            "<leader>ai",
            function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
            desc = "Sidekick Toggle CLI",
        },
        {
            "<leader>at",
            function() require("sidekick.cli").send({ msg = "{this}" }) end,
            mode = { "x", "n" },
            desc = "Send This",
        },
        {
            "<leader>av",
            function() require("sidekick.cli").send({ msg = "{selection}" }) end,
            mode = { "x" },
            desc = "Send Visual Selection",
        },
    },
}
