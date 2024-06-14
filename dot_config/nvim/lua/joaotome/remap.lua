vim.keymap.set("n", "<leader>pv", '<cmd>Neotree current<CR>', {})

--AAAA
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>xh", ":nohl<CR>")


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>")
vim.keymap.set("n", "<leader>sh", "<cmd>sp<CR>")
vim.keymap.set("n", "<leader>sv", "<cmd>vs<CR>")

vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")
-- vim.keymap.set("n", "<A-1>", "<cmd>tabn 1<CR>")
-- vim.keymap.set("n", "<A-2>", "<cmd>tabn 2<CR>")
-- vim.keymap.set("n", "<A-3>", "<cmd>tabn 3<CR>")
-- vim.keymap.set("n", "<A-4>", "<cmd>tabn 4<CR>")

vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")

vim.keymap.set("n", "<leader>bt", "<cmd>TransparentToggle<CR>")
