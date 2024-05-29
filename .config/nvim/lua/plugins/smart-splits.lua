return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		--require('smart-splits').setupa({})
		local wk = require("which-key")
		wk.register({
			A = {
				name = ".resize-split", -- optional group name
				h = { "<cmd>lua ", "grep buffer" },
			},
			--prefix = "<leader>",
		})
		local ss = require("smart-splits")
		wk.register({
			-- resize

			["<A-h>"] = { ss.resize_left, "resize left" },
			["<A-j>"] = { ss.resize_down, "resize down" },
			["<A-k>"] = { ss.resize_up, "resize up" },
			["<A-l>"] = { ss.resize_right, "resize right" },

			-- moving between splits

			["<C-h>"] = { ss.move_cursor_left, "move left" },
			["<C-j>"] = { ss.move_cursor_down, "move down" },
			["<C-k>"] = { ss.move_cursor_right, "move up" },
			["<C-l>"] = { ss.move_cursor_right, "move right" },
			["<A-\\>"] = { ss.move_cursor_previous, "move previous" },

			-- swapping buffers between windows

			["<leader><leader>h"] = { ss.swap_buf_left, "swap left" },
			["<leader><leader>j"] = { ss.swap_buf_down, "swap down" },
			["<leader><leader>k"] = { ss.swap_buf_up, "swap up" },
			["<leader><leader>l"] = { ss.swap_buf_right, "swap right" },
		})
	end,
}
