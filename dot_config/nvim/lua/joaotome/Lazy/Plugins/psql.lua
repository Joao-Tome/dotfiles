return {
	-- {
	-- 	'mzarnitsa/psql',
	-- 	config = function()
	-- 		require('psql').setup({
	-- 			database_name = 'postgres'
	-- 		})
	-- 	end
	-- },
	{
		'guysherman/pg.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'MunifTanjim/nui.nvim',
		},
		config = function()
			vim.keymap.set("n", "<leader>ee", ":<c-u>exec 'PGRunQuery'<CR>")
			vim.keymap.set("n", "<leader>eq", ":PGConnectBuffer<CR>")
		end
	}

}
