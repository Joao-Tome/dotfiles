-- bootstrap lazy.nvim, LazyVim and your plugins

if vim.g.vscode then
  require("VisualStudio")
else
  require("config.lazy")
end
