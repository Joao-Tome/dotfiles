-- vim.cmd("set relativenumber")
-- vim.cmd("set number")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.splitbelow = true
opt.splitright = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.cursorline = true
opt.cursorlineopt.screenline = true
opt.cursorlineopt.number = true

opt.tabpagemax = 4

opt.virtualedit = "block"

opt.ignorecase = true

opt.termguicolors = true

opt.wrap = false

opt.smartindent = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim.undodir"
opt.undofile = true

opt.scrolloff = 8
opt.signcolumn = "yes"

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when Yanking Text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end
})
