return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		-- or                              , branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find Git Files" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fz", builtin.live_grep, { desc = "Find Fuzzy" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Helpers" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
		end
	}
}
