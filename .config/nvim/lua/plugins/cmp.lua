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
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			-- use opts = {} for passing setup options
			-- this is equalent to setup({}) function
		},
		{
			--     Old text                    Command         New text
			-- --------------------------------------------------------------------------------
			--     surr*ound_words             ysiw)           (surround_words)
			--     *make strings               ys$"            "make strings"
			--     [delete ar*ound me!]        ds]             delete around me!
			--     remove <b>HTML t*ags</b>    dst             remove HTML tags
			--     'change quot*es'            cs'"            "change quotes"
			--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
			--     delete(functi*on calls)     dsf             function calls

			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		},
		{
			"Wansmer/treesj",
			keys = { "<space>m", "<space>j", "<space>s" },
			dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
			config = function()
				require("treesj").setup({ --[[ your config ]]
				})
			end,
		},
		{
			"echasnovski/mini.files",
			version = "*",
			init = function()
				require("mini.files").setup()
				local wk = require("which-key")
				wk.register({
					name = ".mini",
					["-"] = { "<CMD>lua MiniFiles.open()<CR>", "open mini" },
					prefix = "<leader>",
				})
			end,
		},
		{
			"echasnovski/mini.move",
			version = "*",
			init = function()
				require("mini.move").setup({
					-- Module mappings. Use `''` (empty string) to disable one.
					mappings = {
						-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
						left = "<M-h>",
						right = "<M-l>",
						down = "<M-j>",
						up = "<M-k>",

						-- Move current line in Normal mode alt-shift j,k,l,h
						line_left = "<M-H>",
						line_right = "<M-L>",
						line_down = "<M-J>",
						line_up = "<M-K>",
					},

					-- Options which control moving behavior
					options = {
						-- Automatically reindent selection during linewise vertical move
						reindent_linewise = true,
					},
				})
			end,
		},
		{
			"stevearc/oil.nvim",
			opts = {},
			-- Optional dependencies
			dependencies = { "nvim-tree/nvim-web-devicons" },
			init = function()
				require("oil").setup()
				local wk = require("which-key")
				wk.register({
					name = ".oil",
					["-"] = { "<CMD>Oil<CR>", "open oil parent" },
				})
			end,
		},
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "honza/vim-snippets" },
		{ "RRethy/vim-illuminate" },
		{ "SirVer/ultisnips" },
		{
			"petertriho/nvim-scrollbar",
			init = function()
				require("scrollbar").setup()
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			init = function()
				require("gitsigns").setup()
			end,
		},
		{
			"quangnguyen30192/cmp-nvim-ultisnips",
			init = function()
				vim.g.UltiSnipsListSnippets = "<c-x>"
				vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
				vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"
				-- vim.g.UltiSnipsEditSplit = "horizontal"
				-- vim.g.UltiSnipsListSnippets = "<c-;>"
				vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "~/.config/nvim/UltiSnips" }
			end,
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
				-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
			},
			config = function()
				local wk = require("which-key")
				wk.register({
					name = ".neotree", -- optional group name
					["-"] = { "<cmd>Neotree<CR> ", "neotree" },
					prefix = "<leader><leader>",
				})
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

			lspconf.pyright.setup(capabilities)
			lspconf.tsserver.setup(capabilities)
			lspconf.nushell.setup(capabilities)
			lspconf.yamlls.setup(capabilities)
			lspconf.gopls.setup(capabilities)
			lspconf.jdtls.setup(capabilities)
			lspconf.bashls.setup(capabilities)
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
