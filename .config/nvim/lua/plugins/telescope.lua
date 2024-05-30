return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		local wk = require("which-key")
		wk.register({
			t = {
				name = ".telescope", -- optional group name
				b = {
					function()
						builtin.current_buffer_fuzzy_find({
							layout_strategy = "vertical",
							layout_config = { width = 0.9 },
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
	end,
}
