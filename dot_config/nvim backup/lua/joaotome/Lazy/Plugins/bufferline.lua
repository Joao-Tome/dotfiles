return {
	"akinsho/bufferline.nvim",
	enabled = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "slant"
		}
	},
	config = function()
		require("bufferline").setup()
		require('transparent').clear_prefix('BufferLine')
	end
}
