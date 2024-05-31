return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/which-key.nvim",
	},
	config = function()
		local options = {
			"default",
			winopts = {
				fullscreen = true,
				preview = {
					-- default     = 'bat',           -- override the default previewer?
					-- default uses the 'builtin' previewer
					border = "border", -- border|noborder, applies only to
					wrap = "wrap", -- wrap|nowrap
					layout = "flip", -- horizontal|vertical|flex
					-- native fzf previewers (bat/cat/git/etc)
					vertical = "down:45%", -- up|down:size
					horizontal = "right:60%", -- right|left:size
					flip_columns = 70, -- #cols to switch to horizontal on flex
				},
			},
			keymap = {
				builtin = {
					["<F1>"] = "toggle-help",
					["<F2>"] = "toggle-fullscreen",
					-- Only valid with the 'builtin' previewer
					["<F3>"] = "toggle-preview-wrap",
					["<F4>"] = "toggle-preview",
					["<F5>"] = "toggle-preview-ccw",
					["<F6>"] = "toggle-preview-cw",
					["<A-j>"] = "preview-page-down",
					["<A-k>"] = "preview-page-up",
					["<S-left>"] = "preview-page-reset",
				},
				fzf = {
					["ctrl-a"] = "toggle-all",
					["alt-a"] = "beginning-of-line",
					-- Only valid with fzf previewers (bat/cat/git/etc)
					["ctrl-q"] = "select-all+accept",
				},
			},
		}
		-- calling `setup` is optional for customization
		require("fzf-lua").setup(options)

		local lua = "<cmd>lua require('fzf-lua')"
		local resume_option = "({ resume = true })<CR>"

		_G.fzf_fb = function()
			local fzf = require("fzf-lua")
			fzf.setup()
			local opts = {
				winopts = {
					fullscreen = true,
					preview = {
						layout = "vertical",
						vertical = "up:55%",
					},
				},
				keymap = {
					builtin = {
						["<A-j>"] = "preview-page-down",
						["<A-k>"] = "preview-page-up",
						["<S-left>"] = "preview-page-reset",
					},
					fzf = {
						["ctrl-a"] = "toggle-all",
						["alt-a"] = "beginning-of-line",
						-- Only valid with fzf previewers (bat/cat/git/etc)
						["ctrl-q"] = "select-all+accept",
					},
				},
			}
			fzf.grep_curbuf(opts)
		end
		local wk = require("which-key")

		_G.fzf_dirs = function(opts)
			_G.fzf_cd_with("fd --hidden --type d", opts)
		end

		_G.fzf_zoxide_dirs = function(opts)
			_G.fzf_cd_with("zoxide query --list", opts)
		end

		_G.fzf_session_dirs = function(opts)
			local fzf_lua = require("fzf-lua")
			opts = opts or {}
			opts.prompt = "Session> "
			opts.fn_transform = function(x)
				return fzf_lua.utils.ansi_codes.blue(x)
			end
			opts.actions = {
				["default"] = function(selected)
					vim.cmd("SessionsLoad " .. selected[1])
				end,
			}
			local command = "fd . " .. vim.fn.stdpath("data") .. "/sessions"
			fzf_lua.fzf_exec(command, opts)
		end

		_G.fzf_cd_with = function(command, opts)
			if _G.fzf_cd_with_active then
				return
			end
			_G.fzf_cd_with_active = true
			local fzf_lua = require("fzf-lua")
			opts = opts or {}
			opts.prompt = "Zoxide> "
			opts.fn_transform = function(x)
				return fzf_lua.utils.ansi_codes.yellow(x)
			end
			opts.actions = {
				["default"] = function(selected)
					vim.cmd("cd " .. selected[1])
				end,
			}
			fzf_lua.fzf_exec(command, opts)
			_G.fzf_cd_with_active = false
		end

		-- map our provider to a user command ':Directories'
		vim.cmd([[command! -nargs=* Directories lua _G.fzf_dirs()]])
		vim.cmd([[command! -nargs=* Zoxide lua _G.fzf_zoxide_dirs()]])
		vim.cmd([[command! -nargs=* Session lua _G.fzf_session_dirs()]])

		wk.register({
			z = {
				name = ".tst", -- optional group name
				b = { "<cmd>lua _G.fzf_fb()<CR>", "grep buffer" },
				z = { "<cmd>lua _G.fzf_zoxide_dirs()<CR>", "zoxide" },
			},
		})

		wk.register({
			f = {
				name = ".fzf", -- optional group name
				q = {
					function()
						print("bar")
					end,
					"Foobar",
				}, -- you can also pass functions!
				b = { _G.fzf_fb, "grep buffer" },
				d = { lua .. ".lsp_document_symbols" .. resume_option, "lsp doc symbols" },
				e = { lua .. ".buffers" .. resume_option, "buffers" },
				f = { lua .. ".files({})<CR>", "Open folder file" },
				g = { lua .. ".git_status" .. resume_option, "git status" },
				h = { lua .. ".command_history" .. resume_option, "command history" },
				k = { lua .. ".keymaps" .. resume_option, "keymaps" },
				o = { lua .. ".files({cwd='~/.config'})<CR>", "Open config file" },
				m = { lua .. ".git_commits" .. resume_option, "git commits" },
				p = { lua .. ".grep_project" .. resume_option, "grep project" },
				s = { _G.fzf_session_dirs, "sessions" },
				t = { lua .. ".tags" .. resume_option, "grep project" },
				w = { lua .. ".lsp_live_workspace_symbols" .. resume_option, "lsp workspace sym" },
				y = { lua .. ".filetypes" .. resume_option, "buffers" },
				z = { _G.fzf_zoxide_dirs, "zoxide" },
			},
		}, {
			prefix = "<leader>",
		})
	end,
}
