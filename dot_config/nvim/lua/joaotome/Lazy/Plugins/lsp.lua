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
					end
				}
			}

			vim.api.nvim_create_autocmd(
				"LspAttach",
				{
					group = vim.api.nvim_create_augroup("lsp-attatch", { clear = true }),
					callback = function()
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
							{ name = "luasnip" } -- For luasnip users.
						},
						{
							{ name = "buffer" }
						}
					)
				}
			)
		end
	}
}
