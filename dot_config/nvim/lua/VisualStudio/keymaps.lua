-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--

local map = vim.keymap.set
local vscode = require("vscode")
vim.g.mapleader = " "

map("n", "<S-l>", function()
  vscode.action("workbench.action.nextEditor")
end)

map("n", "<S-h>", function()
  vscode.action("workbench.action.previousEditor")
end)

map("n", "<leader>wd", function()
  vscode.action("workbench.action.closeActiveEditor")
end)

map("n", "<leader>cd", function()
  vscode.action("mssql.changeDatabase")
end)

map("n", "<leader>cc", function()
  vscode.action("mssql.connect")
end)

--Window Maps

map("n", "<leader>wd", function()
  vscode.action("workbench.action.closeActiveEditor")
end)

map("n", "<leader>wh", function()
  vscode.action("workbench.action.splitEditorDown")
end)
map("n", "<leader>wv", "<cmd>vs<CR>")
map("n", "<leader>ws", function()
  vscode.action("workbench.action.splitEditor")
end)

map("n", "<leader>wh", function()
  vscode.action("workbench.action.navigateLeft")
end)
map("n", "<leader>wj", function()
  vscode.action("workbench.action.navigateDown")
end)
map("n", "<leader>wk", function()
  vscode.action("workbench.action.navigateUp")
end)
map("n", "<leader>wl", function()
  vscode.action("workbench.action.navigateRight")
end)

map("n", "<leader>ww", function()
  vscode.action("workbench.action.togglePanel")
end)
