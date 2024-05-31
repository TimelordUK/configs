return {
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
	config = function()
		vim.keymap.set("n", "<leader>nb", "<cmd>Navbuddy<cr>")
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({
			on_init = function(client)
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
			end,
			settings = {
				Lua = {},
			},
		})

		lspconfig.lemminx.setup({
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

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "cpp",
			callback = function()
				start_lsp({
					name = "clangd",
					cmd = { "clangd" },
				})
			end,
		})

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

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		lspconfig.nushell.setup(capabilities)
		lspconfig.pyright.setup(capabilities)
		lspconfig.yamlls.setup(capabilities)
		lspconfig.tsserver.setup(capabilities)
		lspconfig.gopls.setup(capabilities)
		lspconfig.jdtls.setup(capabilities)
		lspconfig.bashls.setup(vim.lsp.protocol.make_client_capabilities())
		lspconfig.perlls.setup(capabilities)

		-- you can add this in your init.lua
		-- (note: diagnostics are not exclusive to LSP)

		-- Show diagnostics in a floating window
		vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")

		-- Move to the previous diagnostic
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

		-- Move to the next diagnostic
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

		local setup_bindings = function(event)
			local bufmap = function(mode, lhs, rhs)
				local opts = { buffer = event.buf }
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			-- You can find details of these function in the help page
			-- see for example, :help vim.lsp.buf.hover()

			-- Trigger code completion
			bufmap("i", "<C-Space>", "<C-x><C-o>")

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
					-- Jumps to the definition of the type symbol
					o = { vim.lsp.buf.type_definition, "jump type symbol" },
					-- Lists all the references
					r = { vim.lsp.buf.references, "list references" },
				},
			})

			-- Display documentation of the symbol under the cursor
			bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

			-- bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

			-- Jump to declaration
			-- bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

			-- Lists all the implementations for the symbol under the cursor
			-- bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

			-- Jumps to the definition of the type symbol
			-- bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

			-- Lists all the references
			-- bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

			-- Displays a function's signature information
			-- bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

			-- Renames all references to the symbol under the cursor
			bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

			-- Format current file
			bufmap("n", "<F3>", "<cmd>lua vim.lsp.buf.format()<cr>")

			-- Selects a code action available at the current cursor position
			bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
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
	end,
}
