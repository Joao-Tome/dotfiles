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
						timeout_ms = 5000,
						lsp_fallback = true
					},
					formatters_by_ft = {
						csharp = { 'csharpier' },
						lua = { 'stylua' },
						go = { 'goimports-reviser', 'gofumpt' },
						-- Use a sub-list to run only the first available formatter
						javascript = { { "prettierd", "prettier" } },
						typescript = { { "prettierd", "prettier" } },
						json = { 'fixjson' }
					}
				}

			},
		},
		config = function()
			require("fidget").setup()
			require("mason").setup()
			require("mason-lspconfig").setup {
				ensure_installed = {
					"lua_ls",
					-- "tsserver",
					"rust_analyzer",
					"gopls",
					'jsonls',
				},
				automatic_installation = false,
				handlers = {
					function(server_name)
						if server_name ~= "tsserver" then
							require("lspconfig")[server_name].setup({})
						end
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
					-- ["tsserver"] = function()
					-- 	require('lspconfig').tsserver.setup({
					-- 		on_attach = function(client, bufnr)
					-- 			require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
					-- 		end
					-- 	})
					-- end

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
						vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)
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
	},

	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {
	-- 		settings = {
	-- 			-- spawn additional tsserver instance to calculate diagnostics on it
	-- 			separate_diagnostic_server = false,
	-- 			-- "change"|"insert_leave" determine when the client asks the server about diagnostic
	-- 			publish_diagnostic_on = "insert_leave",
	-- 			-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
	-- 			-- "remove_unused_imports"|"organize_imports") -- or string "all"
	-- 			-- to include all supported code actions
	-- 			-- specify commands exposed as code_actions
	-- 			expose_as_code_action = {},
	-- 			-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
	-- 			-- not exists then standard path resolution strategy is applied
	-- 			tsserver_path = nil,
	-- 			-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
	-- 			-- (see 💅 `styled-components` support section)
	-- 			tsserver_plugins = {},
	-- 			-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
	-- 			-- memory limit in megabytes or "auto"(basically no limit)
	-- 			tsserver_max_memory = 600,
	-- 			-- described below
	-- 			tsserver_format_options = {},
	-- 			tsserver_file_preferences = {},
	-- 			-- locale of all tsserver messages, supported locales you can find here:
	-- 			-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
	-- 			tsserver_locale = "en",
	-- 			-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
	-- 			complete_function_calls = false,
	-- 			include_completions_with_insert_text = true,
	-- 			-- CodeLens
	-- 			-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
	-- 			-- possible values: ("off"|"all"|"implementations_only"|"references_only")
	-- 			code_lens = "off",
	-- 			-- by default code lenses are displayed on all referencable values and for some of you it can
	-- 			-- be too much this option reduce count of them by removing member references from lenses
	-- 			disable_member_code_lens = true,
	-- 			-- JSXCloseTag
	-- 			-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
	-- 			-- that maybe have a conflict if enable this feature. )
	-- 			jsx_close_tag = {
	-- 				enable = false,
	-- 				filetypes = { "javascriptreact", "typescriptreact" },
	-- 			}
	-- 		},
	-- 	},
	-- }
}
