return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-file-browser.nvim",
			dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		},
	},
	config = function()
		local builtin = require("telescope.builtin")
		local wk = require("which-key")
		local ext = require("telescope").extensions
		vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
		wk.register({
			t = {
				name = ".telescope", -- optional group name
				b = {
					function()
						builtin.current_buffer_fuzzy_find({
							layout_strategy = "vertical",
							layout_config = { width = 0.9, height = 0.8 },
						})
					end,
					"current buffer",
				},
				l = { ext.file_browser.file_browser, "file browser" },
				f = { builtin.find_files, "find files" },
				p = { builtin.live_grep, "project grep" },
				q = { builtin.quickfix, "quickfix" },
				e = { builtin.buffers, "buffers" },
				m = { builtin.man_pages, "man pages" },
				i = { "<cmd>Telescope neoclip<CR>", "neoclip" },
				h = { builtin.help_tags, "help tags" },
				r = { builtin.registers, "registers" },
				y = { builtin.filetypes, "filetypes" },
			},
		}, {
			prefix = "<leader>",
		})
	end,
}
