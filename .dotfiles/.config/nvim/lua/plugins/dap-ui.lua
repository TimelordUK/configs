return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"folke/neodev.nvim",
	},
	config = function()
		require("dapui").setup()
		require("neodev").setup({
			library = {
				plugins = { "nvim-dap-ui" },
				types = true,
			},
		})
		local wk = require("which-key")
		-- .exit               Closes the REPL
		-- .c or .continue     Same as |dap.continue|
		-- .n or .next         Same as |dap.step_over|
		-- .into               Same as |dap.step_into|
		-- .into_target        Same as |dap.step_into{askForTargets=true}|
		-- .out                Same as |dap.step_out|
		-- .up                 Same as |dap.up|
		-- .down               Same as |dap.down|
		-- .goto               Same as |dap.goto_|
		-- .scopes             Prints the variables in the current scopes
		-- .threads            Prints all threads
		-- .frames             Print the stack frames
		-- .capabilities       Print the capabilities of the debug adapter
		-- .b or .back         Same as |dap.step_back|
		-- .rc or
		-- .reverse-continue   Same as |dap.reverse_continue|
		--
		--
		wk.register({
			-- quick debug
			["<F8>"] = { "<cmd>DapStepOver<CR>", "step over" },
			["<F7>"] = { "<cmd>DapStepInto<CR>", "step into" },
			["<F10>"] = { "<cmd>DapStepOut<CR>", "step out" },
			["<F5>"] = { "<cmd>lua require('dap').continue()<CR>", "continue" },
		})

		local dap, dapui = require("dap"), require("dapui")
		local dappy = require("dap-python")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		wk.register({
			d = {
				name = ".dap", -- optional group name
				b = { "<cmd>DapToggleBreakpoint<CR>", "breakpoint" },
				c = { dap.continue, "continue" },
				d = { dap.down, "down frame" },
				e = { dapui.eval, "expression" },
				h = { ".scopes .threads .frames .up .down" },
				i = { "<cmd>DapStepInto<CR>", "step into" },
				l = { dappy.test_class, "test class" },
				m = { dappy.test_method, "test method" },
				n = { "<cmd>DapStepOver<CR>", "step over" },
				o = { dapui.open, "open dapui" },
				p = { dappy.test_method, "debug python" },
				s = { "<cmd>DapStepOut<CR>", "step out" },
				t = { "<cmd>DapTerminate<CR>", "dap terminate" },
				u = { dap.up, "up frame" },
				x = { dapui.close, "close dapui" },
			},
		}, {
			prefix = "<leader>",
		})
	end,
}
