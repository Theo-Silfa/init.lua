-- open file EXplorer
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")
vim.keymap.set("n", "<leader>pV", function ()
    require("oil").open(vim.loop.cwd())
end)

-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- half page jump and stay at the center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- half page search and stay at the center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy selection to system buffer
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")
-- copy line to system buffer
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- replace the current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--apply fix from lsp
local opts = { noremap=true, silent=true }
local function quickfix()
    vim.lsp.buf.code_action({
        apply = true
    })
end
vim.keymap.set('n', '<leader>qf', quickfix, opts)

--diagnostic navigation
vim.keymap.set('n', ']t', function()
    vim.diagnostic.goto_next({float = false})
end)
vim.keymap.set('n', '[t', function()
    vim.diagnostic.goto_prev({float = false})
end)
