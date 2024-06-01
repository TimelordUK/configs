return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-file-browser.nvim",
			dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		},
		"nvim-telescope/telescope-ui-select.nvim",
	},
	init = function()
		local builtin = require("telescope.builtin")
		local telescope = require("telescope")
		local wk = require("which-key")
		-- ctrl-/ to see map in fb mode
		vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
		wk.register({
			t = {
				name = ".telescope", -- optional group name
				b = {
					function()
						builtin.current_buffer_fuzzy_find({
							layout_strategy = "vertical",
							layout_config = { width = 0.9, height = 0.9 },
						})
					end,
					"current buffer",
				},
				f = { builtin.find_files, "find files" },
				p = { builtin.live_grep, "project grep" },
				q = { builtin.quickfix, "quickfix" },
				e = { builtin.buffers, "buffers" },
				m = { builtin.man_pages, "man pages" },
				h = { builtin.help_tags, "help tags" },
				r = { builtin.registers, "registers" },
				y = { builtin.filetypes, "filetypes" },
			},
		}, {
			prefix = "<leader>",
		})
		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { width = 0.9, height = 0.9 },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						-- even more opts
					}),
				},
			},
		})
		telescope.load_extension("ui-select")
	end,
}
