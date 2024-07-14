return {
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			local cfg = {
				relculright = true,
				ft_ignore = { 'neo-tree' },
				segments = {
					{ sign = { name = { 'Dap' }, maxwidth = 1, auto = false }, click = 'v:lua.ScSa' },
					{ sign = { name = { 'todo*' }, maxwidth = 1 } },
					{
						sign = { namespace = { 'diagnostic' }, maxwidth = 1, auto = false },
						click = 'v:lua.ScSa',
					},
					{
						sign = { namespace = { 'gitsigns*' }, maxwidth = 1, colwidth = 2, auto = false },
						click = 'v:lua.ScSa',
					},
					{ text = { builtin.lnumfunc, '  ' }, click = 'v:lua.ScLa' },
					{ text = { builtin.foldfunc, ' ' },  click = 'v:lua.ScFa' },
				},
			}
			--#endregion
			require("statuscol").setup(cfg)
		end,
	}
}
