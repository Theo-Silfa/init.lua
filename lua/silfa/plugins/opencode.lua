vim.g.opencode_opts = {
    server = {
        start = function()
            vim.system({ "tmux", "split-window", "-h", "-l", "40%", "opencode", "--agent", "plan", "--port" })
        end
    }
}

local stop = function()
    local pane_id, pane_pid = vim.fn.system(
            "tmux list-panes -F '#{pane_id} #{pane_pid} #{pane_current_command}' -t . | grep opencode")
        :match(
            "(%S+)%s+(%S+)")

    vim.system({ "kill", "-9", pane_pid })
    vim.system({ "tmux", "kill-pane", "-t", pane_id })
end

local toggle = function()
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
end

vim.api.nvim_create_autocmd("VimLeave", {
    callback = stop,
})

vim.o.autoread = true -- Required for `opts.events.reload`

vim.keymap.set({ "n" }, "<leader>l", function() return require("opencode").operator("@buffer ") .. "_" end,
    { desc = "Add buffer path to opencode", expr = true })
vim.keymap.set({ "x" }, "<leader>l", function() return require("opencode").operator("@this ") end,
    { desc = "Add range to opencode", expr = true })
vim.keymap.set({ "n", "t" }, "<leader>ai", toggle,
    { desc = "Toggle opencode" })
