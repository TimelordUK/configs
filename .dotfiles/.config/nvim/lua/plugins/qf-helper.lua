return {
	"stevearc/qf_helper.nvim",
	config = function()
		require("qf_helper").setup()
		local wk = require("which-key")
		wk.register({
			q = {
				name = ".qf helper", -- optional group name
				n = { "<cmd>QNext<CR>", "next quickfix" },
				p = { "<cmd>QPrev<CR>", "prev quickfix" },
				q = { "<cmd>QFToggle!<CR>", "qf toggle" },
				l = { "<cmd>LLToggle!<CR>", "ll toggle" },
			},
		}, {
			prefix = "<leader>",
		})
	end,
}
