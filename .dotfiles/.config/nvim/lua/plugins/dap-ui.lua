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
      wk.add(
         {
            { "<F10>", "<cmd>DapStepOut<CR>",                    desc = "step out" },
            { "<F5>",  "<cmd>lua require('dap').continue()<CR>", desc = "continue" },
            { "<F7>",  "<cmd>DapStepInto<CR>",                   desc = "step into" },
            { "<F8>",  "<cmd>DapStepOver<CR>",                   desc = "step over" },
         }
      )

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

      wk.add(
         {
            { "<leader>d",  group = ".dap" },
            { "<leader>db", "<cmd>DapToggleBreakpoint<CR>",             desc = "breakpoint" },
            { "<leader>dc", dap.continue,                               desc = "continue" },
            { "<leader>dd", dap.down,                                   desc = "down frame" },
            { "<leader>de", dap.eval,                                   desc = "expression" },
            { "<leader>dh", desc = ".scopes .threads .frames .up .down" },
            { "<leader>di", "<cmd>DapStepInto<CR>",                     desc = "step into" },
            { "<leader>dl", dappy.test_class,                           desc = "test class" },
            { "<leader>dm", dappy.test_method,                          desc = "test method" },
            { "<leader>dn", "<cmd>DapStepOver<CR>",                     desc = "step over" },
            { "<leader>do", dappy.open,                                 desc = "open dapui" },
            { "<leader>dp", dappy.test_method,                          desc = "debug python" },
            { "<leader>ds", "<cmd>DapStepOut<CR>",                      desc = "step out" },
            { "<leader>dt", "<cmd>DapTerminate<CR>",                    desc = "dap terminate" },
            { "<leader>du", dappy.up,                                   desc = "up frame" },
            { "<leader>dx", dapui.close,                                desc = "close dapui" },
         }
      )
   end,
}
