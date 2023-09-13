vim.g.mapleader = ' '

-- open file EXplorer (nvimtree)
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>pV", ":NvimTreeFindFileToggle<cr>")

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

