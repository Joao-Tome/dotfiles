--AAAA
--Move linha inteira usando J e K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n", "<leader>hd", ":nohl<CR>", { desc = "Disable Highlight" })


--Remapeia C-d e C-u para centralizar ao usar.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--Remapeia n e N para centralizar ao usar.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste and keep register" })

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", "\"+Y", { desc = "yank to clipboard" })

vim.keymap.set("n", "<leader>p", "\"+p", { desc = "paste from clipboard" })
vim.keymap.set("n", "<leader>P", "\"+P", { desc = "paste from clipboard" })

--Window Management
vim.keymap.set("n", "<leader>wd", "<cmd>close<CR>", { desc = "Close Window" })
vim.keymap.set("n", "<leader>wh", "<cmd>sp<CR>", { desc = "Split Horizontal" })
vim.keymap.set("n", "<leader>wv", "<cmd>vs<CR>", { desc = "split Vertical" })

vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Down Window" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window" })

vim.keymap.set("n", "<leader><tab>o", "<cmd>tabnew<CR>", { desc = "Create New Tab" })
-- vim.keymap.set("n", "<A-1>", "<cmd>tabn 1<CR>")
-- vim.keymap.set("n", "<A-2>", "<cmd>tabn 2<CR>")
-- vim.keymap.set("n", "<A-3>", "<cmd>tabn 3<CR>")
-- vim.keymap.set("n", "<A-4>", "<cmd>tabn 4<CR>")

vim.keymap.set("n", "<leader><tab>p", "<cmd>tabp<CR>", { desc = "Go to Previous Tab" })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabn<CR>", { desc = "Go to Next Tab" })

vim.keymap.set("n", "<S-l>", "<cmd>tabn<CR>", { desc = "Go to Next Tab" })
vim.keymap.set("n", "<S-h>", "<cmd>tabp<CR>", { desc = "Go to Previous Tab" })

vim.keymap.set("n", "<leader>wt", "<cmd>TransparentToggle<CR>", { desc = "Toggle Transparent" })
