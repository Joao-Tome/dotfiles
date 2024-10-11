return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
	},
	{
		'navarasu/onedark.nvim',
		priority = 1001,
		opts = {
			-- Main options --
			style = 'darker',    -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			transparent = false, -- Show/hide background
			term_colors = true,  -- Change terminal color as per the selected theme style
			ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
			cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

			-- toggle theme style ---
			toggle_style_key = nil,                                                     -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
			toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

			-- Change code style ---
			-- Options are italic, bold, underline, none
			-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
			code_style = {
				comments = 'italic',
				keywords = 'none',
				functions = 'none',
				strings = 'none',
				variables = 'none'
			},

			-- Lualine options --
			lualine = {
				transparent = false, -- lualine center bar transparency
			},

			-- Custom Highlights --
			colors = {}, -- Override default colors
			highlights = {}, -- Override highlight groups

			-- Plugins Config --
			diagnostics = {
				darker = true, -- darker colors for diagnostic
				undercurl = true, -- use undercurl instead of underline for diagnostics
				background = true, -- use background color for virtual text
			},
		}
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false,  -- Force no italic
				no_bold = false,    -- Force no bold
				no_underline = false, -- Force no underline
				styles = {          -- Handles the styles of general hi groups (see `:h highlight-args`):
					ments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				color_overrides = {
					mocha = {
						surface1 = "#666666",
					},
				},
				custom_highlights = {},
				default_integrations = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
			vim.cmd.colorscheme "catppuccin"
		end
	},
	-- Lazy
	{
		"vague2k/huez.nvim",
		-- if you want registry related features, uncomment this
		import = "huez-manager.import",
		config = function()
			require("huez").setup(
				{
					path = vim.fs.normalize(vim.fn.stdpath("data") --[[@as string]]) .. "/huez",
					fallback = "catppuccin",
					suppress_messages = true,
					exclude = { "desert", "evening", "industry", "koehler", "morning", "murphy", "pablo", "peachpuff", "ron", "shine", "slate", "torte", "zellner", "blue", "darkblue", "delek", "quiet", "elflord", "habamax", "lunaperche", "zaibatsu", "wildcharm", "sorbet", "vim", },
					picker = {
						themes = {
							layout = "right",
							opts = {},
						},
						favorites = {
							layout = "right",
							opts = {},
						},
						live = {
							layout = "right",
							opts = {},
						},
						ensured = {
							layout = "right",
							opts = {},
						},
					},
				}
			)

			local pickers = require("huez.pickers")

			vim.keymap.set("n", "<leader>co", pickers.themes, {})
			vim.keymap.set("n", "<leader>cof", pickers.favorites, {})
			vim.keymap.set("n", "<leader>col", pickers.live, {})
			vim.keymap.set("n", "<leader>coe", pickers.ensured, {})
		end,
	}
}
