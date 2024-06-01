return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{
					"SmiteshP/nvim-navbuddy",
					dependencies = {
						"SmiteshP/nvim-navic",
						"MunifTanjim/nui.nvim",
					},
					opts = { lsp = { auto_attach = true } },
				},
			},
		},
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "honza/vim-snippets" },
		{ "SirVer/ultisnips" },
		{
			"quangnguyen30192/cmp-nvim-ultisnips",
			init = function()
				vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
				vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"
				-- vim.g.UltiSnipsEditSplit = "horizontal"
				-- vim.g.UltiSnipsListSnippets = "<c-;>"
				vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "~/.config/nvim/UltiSnips" }
			end,
		},
	},
	init = function()
		local lsps = function()
			vim.keymap.set("n", "<leader>nb", "<cmd>Navbuddy<cr>")
			local lspconf = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local capas = require("cmp_nvim_lsp").default_capabilities()
			capas.on_init = function(client)
				local path = client.workspace_folders[1].name
				if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
					return
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths here.
							-- "${3rd}/luv/library"
							-- "${3rd}/busted/library",
						},
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
						-- library = vim.api.nvim_get_runtime_file("", true)
					},
				})
			end
			capas.settings = {
				Lua = {},
			}
			lspconf.lua_ls.setup(capas)

			lspconf.lemminx.setup({
				settings = {
					xml = {
						server = {
							workDir = "~/.cache/lemminx",
						},
					},
				},
			})

			local function start_lsp(cfg)
				vim.schedule(function()
					vim.lsp.start(cfg)
				end)
			end

			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	pattern = "cpp",
			-- 	callback = function()
			-- 		start_lsp({
			-- 			name = "clangd",
			-- 			cmd = { "clangd" },
			-- 		})
			-- 	end,
			-- })
			--
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "json",
				callback = function()
					start_lsp({
						name = "vscode-json-languageserver",
						cmd = { "vscode-json-languageserver", "--stdio" },
					})
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					start_lsp({
						name = "marksman",
						cmd = { "marksman" },
					})
				end,
			})

			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities.textDocument.foldingRange = {
			-- 	dynamicRegistration = false,
			-- 	lineFoldingOnly = true,
			-- }
			--
			lspconf.pyright.setup(capabilities)
			lspconf.tsserver.setup(capabilities)
			lspconf.nushell.setup(capabilities)
			lspconf.yamlls.setup(capabilities)
			lspconf.gopls.setup(capabilities)
			lspconf.jdtls.setup(capabilities)
			lspconf.bashls.setup(vim.lsp.protocol.make_client_capabilities())
			lspconf.perlls.setup(capabilities)
			lspconf.clangd.setup(capabilities)

			-- you can add this in your init.lua
			-- (note: diagnostics are not exclusive to LSP)

			local setup_bindings = function(event)
				-- You can find details of these function in the help page
				-- see for example, :help vim.lsp.buf.hover()

				local wk = require("which-key")
				wk.register({
					g = {
						name = ".lsp", -- optional group name
						-- Jump to the definition
						d = { vim.lsp.buf.definition, "jump definition" },
						-- Jump to declaration
						D = { vim.lsp.buf.declaration, "jump declaration" },
						-- Lists all the implementations for the symbol under the cursor
						i = { vim.lsp.buf.implementation, "list implementations" },
						-- Show diagnostics in a floating window
						l = { vim.diagnostic.open_float, "diag in float" },
						-- Jumps to the definition of the type symbol
						o = { vim.lsp.buf.type_definition, "jump type symbol" },
						-- Lists all the references
						r = { vim.lsp.buf.references, "list references" },
					},
				})

				wk.register({
					-- Trigger code completion
					-- ["<C_Space"] = { "<C-x><C-o>", "code complete" },
					-- Display documentation of the symbol under the cursor
					K = { vim.lsp.buf.hover, "hover symbol" },
					-- Renames all references to the symbol under the cursor
					["<F2>"] = { vim.lsp.buf.rename, "rename symbol" },
					-- Format current file
					["<F3>"] = { vim.lsp.buf.format, "reformat" },
					-- Selects a code action available at the current cursor position
					["<F4>"] = { vim.lsp.buf.code_action, "code action" },
					-- Move to the previous diagnostic
					["[d"] = { vim.diagnostic.goto_prev, "prev diag" },
					-- Move to the next diagnostic
					["]d"] = { vim.diagnostic.goto_next, "goto diag" },
				})
			end
			local function bind_lsp(event)
				vim.schedule(function()
					setup_bindings(event)
				end)
			end
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = bind_lsp,
			})
		end
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					--vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "ultisnips" }, -- For ultisnips users.
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "nvim_lsp_signature_help" },
				-- { name = 'luasnip' }, -- For luasnip users.
				-- { name = 'snippy' }, -- For snippy users.
			}),
		})

		-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
		-- Set configuration for specific filetype.
		--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]
		--
		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
		lsps()

		-- Set up lspconfig.
		-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
		-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
		--    capabilities = capabilities
		-- }
	end,
}
