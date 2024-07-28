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
		local bff = function()
			builtin.current_buffer_fuzzy_find({
				layout_strategy = "vertical",
				layout_config = { width = 0.9, height = 0.9 },
			})
		end
		-- ctrl-/ to see map in fb mode
		vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
		wk.add({
			{ "<leader>t", group = ".telescope" },
			{ "<leader>tb", bff, desc = "fuzzy find" },
			{ "<leader>te", builtin.buffers, desc = "buffers" },
			{ "<leader>tf", builtin.find_files, desc = "find files" },
			{ "<leader>th", builtin.help_tags, desc = "help tags" },
			{ "<leader>tm", builtin.man_pages, desc = "man pages" },
			{ "<leader>tp", builtin.live_grep, desc = "project grep" },
			{ "<leader>tq", builtin.quickfix, desc = "quickfix" },
			{ "<leader>tr", builtin.registers, desc = "registers" },
			{ "<leader>ty", builtin.filetypes, desc = "filetypes" },
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
