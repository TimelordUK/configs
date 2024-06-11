return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	--   init = function() vim.g.barbar_auto_setup = false end,
	config = function()
		local wk = require("which-key")

		wk.register({
			name = ".barbar select",
			-- Move to previous/next
			["<A-,>"] = { "<Cmd>BufferPrevious<CR>", "goto prev buffer" },
			["<A-.>"] = { "<Cmd>BufferNext<CR>", "goto next buffer" },
			-- Re-order to previous/next
			["<A-<>"] = { "<Cmd>BufferMovePrevious<CR>", "move buffer left" },
			["<A->>"] = { "<Cmd>BufferMoveNext<CR>", "move buffer right" },
			-- Goto buffer in position...
			["<A-1>"] = { "<Cmd>BufferGoto 1<CR>", "goto buffer 1" },
			["<A-2>"] = { "<Cmd>BufferGoto 2<CR>", "goto buffer 2" },
			["<A-3>"] = { "<Cmd>BufferGoto 3<CR>", "goto buffer 3" },
			["<A-4>"] = { "<Cmd>BufferGoto 4<CR>", "goto buffer 4" },
			["<A-5>"] = { "<Cmd>BufferGoto 5<CR>", "goto buffer 5" },
			["<A-6>"] = { "<Cmd>BufferGoto 6<CR>", "goto buffer 6" },
			["<A-7>"] = { "<Cmd>BufferGoto 7<CR>", "goto buffer 7" },
			["<A-8>"] = { "<Cmd>BufferGoto 8<CR>", "goto buffer 8" },
			["<A-9>"] = { "<Cmd>BufferGoto 9<CR>", "goto buffer 9" },
			["<A-0>"] = { "<Cmd>BufferLast<CR>", "goto last buffer" },
			-- Pin/unpin buffer
			["<A-p>"] = { "<Cmd>BufferPin<CR>", "toggle pin buffer" },
			-- Close buffer
			["<A-c>"] = { "<Cmd>BufferClose<CR>", "close buffer" },
			-- Magic buffer-picking mode
			["<C-p>"] = { "<Cmd>BufferPick<CR>", "magic buffer pick" },
		})

		-- Close commands
		wk.register({
			c = {
				name = ".barbar close", -- optional group name
				a = { "<cmd>BufferCloseAllButCurrentOrPinned<CR>", "kill all but curr/pin buf" },
				c = { "<cmd>BufferCloseAllButCurrent<CR>", "kill all but curr buf" },
				l = { "<cmd>BufferCloseBuffersLeft<CR>", "kill all left" },
				r = { "<cmd>BufferCloseBuffersRight<CR>", "kill all right" },
				w = { "<cmd>BufferWipeout<CR>", "wipeout current" },
			},
		}, {
			prefix = "<leader>",
		})

		-- scroll commands
		wk.register({
			name = ".barbar scroll", -- optional group name
			l = { "<cmd>BufferScrollLeft<CR>", "scroll left" },
			r = { "<cmd>BufferScrollRight<CR>", "scroll right" },
		}, {
			prefix = "ss",
		})

		-- Sort automatically by...
		wk.register({
			b = {
				name = ".barbar sort",
				b = { "<Cmd>BufferOrderByBufferNumber<CR>", "sort by buffer num" },
				n = { "<Cmd>BufferOrderByName<CR>", "sort by name" },
				d = { "<Cmd>BufferOrderByDirectory<CR>", "sort by directory" },
				l = { "<Cmd>BufferOrderByLanguage<CR>", "sort by language" },
				w = { "<Cmd>BufferOrderByWindowNumber<CR>", "sort by window num" },
			},
		}, {
			prefix = "<Space>",
		})

		--                 :BufferWipeout
		-- Close commands
		--                 :BufferCloseAllButCurrent
		--                 :BufferCloseAllButPinned
		--                 :BufferCloseAllButCurrentOrPinned
		--                 :BufferCloseBuffersLeft
		--                 :BufferCloseBuffersRight
		-- Magic buffer-picking mode
		-- map("n", "<C-p>", "<Cmd>BufferPick<CR>", options)
		-- Sort automatically by...

		-- Other:
		-- :BarbarEnable - enables barbar (enabled by default)
		-- :BarbarDisable - very bad command, should never be used
	end,
}
