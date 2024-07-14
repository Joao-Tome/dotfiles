return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
			{
				"stevearc/conform.nvim",
				opts = {
					notify_on_error = false,
					format_on_save = {
						timeout_ms = 500,
						lsp_fallback = true
					},
					formatters_by_ft = {
						csharp = { 'csharpier' },
						lua = { 'stylua' },
						go = { 'goimports-reviser', 'gofumpt' },
						-- Use a sub-list to run only the first available formatter
						javascript = { { "prettierd", "prettier" } },
						json = { 'fixjson' }
					}
				}

			}
		},
		config = function()
			require("fidget").setup()
			require("mason").setup()
			require("mason-lspconfig").setup {
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"rust_analyzer",
					"gopls",
					'jsonls',
				},
				automatic_installation = false,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup(
							{
								settings = {
									Lua = {
										diagnostics = {
											globals = { "vim" }
										}
									}
								}
							}
						)
					end,
					["gopls"] = function()
						local lspconfig = require("lspconfig")
						local util = require("lspconfig/util")
						lspconfig.gopls.setup({
							cmd = { "gopls" },
							fileytpes = { "go", "gomod", "gowork", "gotmpl" },
							root_dir = util.root_pattern("go.work", "go.mod", ".git"),
							settings = {
								gopls = {
									completeUnimported = true,
									usePlaceholders = true,
									analyses = {
										unusedparams = true,
									}
								}
							}
						})
					end,
					["jsonls"] = function()
						local capabilities = vim.lsp.protocol.make_client_capabilities()
						capabilities.textDocument.completion.completionItem.snippetSupport = true

						require 'lspconfig'.jsonls.setup {
							capabilities = capabilities,
						}
					end,
					["tsserver"] = function()
						require('lspconfig').tsserver.setup({
							on_attach = function(client, bufnr)
								require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
							end
						})
					end

				}
			}

			vim.api.nvim_create_autocmd(
				"LspAttach",
				{
					group = vim.api.nvim_create_augroup("lsp-attatch", { clear = true }),
					callback = function(args)
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						local bufnr = args.buf
						require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
						vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions)
						vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)
						vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations)
						vim.keymap.set("n", "<leader>D", require("telescope.builtin").lsp_type_definitions)
						vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols)
						vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)
						vim.keymap.set("n", "<leader>rs", vim.lsp.buf.rename)
						vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
						vim.keymap.set("n", "K", vim.lsp.buf.hover)
					end
				}
			)

			local cmp = require "cmp"

			cmp.setup(
				{
					snippet = {
						-- REQUIRED - you must specify a snippet engine
						expand = function(args)
							require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						end
					},
					window = {
						completion = cmp.config.window.bordered(),
						-- documentation = cmp.config.window.bordered(),
					},
					mapping = cmp.mapping.preset.insert(
						{
							["<C-b>"] = cmp.mapping.scroll_docs(-4),
							["<C-n>"] = cmp.mapping.select_next_item(),
							["<C-p>"] = cmp.mapping.select_prev_item(),
							["<C-f>"] = cmp.mapping.scroll_docs(4),
							["<C-Space>"] = cmp.mapping.complete(),
							["<C-e>"] = cmp.mapping.abort(),
							["<Tab>"] = cmp.mapping.confirm({ select = true }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
						}
					),
					sources = cmp.config.sources(
						{
							{ name = "nvim_lsp" },
							{ name = "luasnip" }, -- For luasnip users.
							{ name = "codeium" }
						},
						{
							{ name = "buffer" }
						}
					)
				}
			)
		end
	},
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			require("actions-preview").setup {
				-- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
				diff = {
					ctxlen = 3,
				},

				-- priority list of external command to highlight diff
				-- disabled by defalt, must be set by yourself
				highlight_command = {
					-- require("actions-preview.highlight").delta(),
					-- require("actions-preview.highlight").diff_so_fancy(),
					-- require("actions-preview.highlight").diff_highlight(),
				},

				-- priority list of preferred backend
				backend = { "telescope", "nui" },

				-- options related to telescope.nvim
				telescope = vim.tbl_extend(
					"force",
					-- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
					require("telescope.themes").get_dropdown(),
					-- a table for customizing content
					{
						-- a function to make a table containing the values to be displayed.
						-- fun(action: Action): { title: string, client_name: string|nil }
						make_value = nil,

						-- a function to make a function to be used in `display` of a entry.
						-- see also `:h telescope.make_entry` and `:h telescope.pickers.entry_display`.
						-- fun(values: { index: integer, action: Action, title: string, client_name: string }[]): function
						make_make_display = nil,
					}
				),

				-- options for nui.nvim components
				nui = {
					-- component direction. "col" or "row"
					dir = "col",
					-- keymap for selection component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu#keymap
					keymap = nil,
					-- options for nui Layout component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/layout
					layout = {
						position = "50%",
						size = {
							width = "60%",
							height = "90%",
						},
						min_width = 40,
						min_height = 10,
						relative = "editor",
					},
					-- options for preview area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
					preview = {
						size = "60%",
						border = {
							style = "rounded",
							padding = { 0, 1 },
						},
					},
					-- options for selection area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu
					select = {
						size = "40%",
						border = {
							style = "rounded",
							padding = { 0, 1 },
						},
					},
				},
			}
			vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
		end,
	}
}
