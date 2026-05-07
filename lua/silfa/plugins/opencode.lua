vim.g.opencode_opts = {
    server = {
        start = function()
            vim.system({ "tmux", "split-window", "-h", "-l", "40%", "opencode", "--agent", "plan", "--port" })
        end,
        stop = function()
            local pane_id, pane_pid = vim.fn.system(
                    "tmux list-panes -F '#{pane_id} #{pane_pid} #{pane_current_command}' -t . | grep opencode")
                :match(
                    "(%S+)%s+(%S+)")

            vim.system({ "kill", "-9", pane_pid })
            vim.system({ "tmux", "kill-pane", "-t", pane_id })
        end,
        toggle = function()
            local pane_id, is_zoomed = vim.fn.system(
                    "tmux list-panes -F '#{pane_id} #{window_zoomed_flag} #{pane_current_command}' -t . | grep opencode")
                :match(
                    "(%S+)%s+(%S+)")

            if pane_id == nil then
                vim.g.opencode_opts.server.start()
            elseif is_zoomed == "1" then
                vim.system({ "tmux", "select-pane", "-t", pane_id })
            else
                vim.system({ "tmux", "resize-pane", "-Z" })
            end
        end,
    }
}

vim.api.nvim_create_autocmd("VimLeave", {
    callback = vim.g.opencode_opts.server.stop,
})

vim.o.autoread = true         -- Required for `opts.events.reload`

vim.keymap.set({ "n", "x" }, "<C-i>", function() require("opencode").ask("@this: ", { submit = true }) end,
    { desc = "Ask opencode…" })
vim.keymap.set({ "n", "t" }, "<leader>ai", function() require("opencode").toggle() end,
    { desc = "Toggle opencode" })
