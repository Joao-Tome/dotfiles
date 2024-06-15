return {
	'mfussenegger/nvim-dap',
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		'mfussenegger/nvim-dap',
		"theHamsta/nvim-dap-virtual-text",
		"williamboman/mason.nvim",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		dap.defaults.fallback.force_external_terminal = true

		dap.defaults.fallback.external_terminal = {
			command = '/usr/bin/wezterm',
			args = { '-e' },
		}
		dap.adapters.coreclr = {
			type = 'executable',
			command = '/home/joaotome/.local/netcoredbg/netcoredbg',
			args = { '--interpreter=vscode' }
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
				end,
			},
		}

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>bg", dap.run_to_cursor)

		vim.keymap.set("n", "<F5>", dap.continue)
		vim.keymap.set("n", "<F10>", dap.step_over)
		vim.keymap.set("n", "<F11>", dap.step_into)
		vim.keymap.set("n", "<F5>", dap.continue)
	end


}
