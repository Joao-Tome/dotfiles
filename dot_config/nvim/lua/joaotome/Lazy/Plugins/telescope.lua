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
			vim.keymap.set("n", "<leader>pf", builtin.git_files, {})
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>pk", builtin.keymaps, {})

			vim.keymap.set("n", "<leader>pn", function()
				builtin.find_files { cwd = vim.fn.stdpath 'config' }
			end, {})
		end
	}
}
