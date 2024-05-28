return
{
   "rcarriga/nvim-dap-ui",
   dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
   },
   config = function()
      require("dapui").setup()
      require("neodev").setup({
         library = {
            plugins = { "nvim-dap-ui" },
            types = true
         },
      })
      local wk = require('which-key')
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
      vim.keymap.set('n', '<F8>', '<cmd>DapStepOver<CR>')
      vim.keymap.set('n', '<F10>', '<cmd>DapStepOut<CR>')
      vim.keymap.set('n', '<F7>', '<cmd>DapStepInto<CR>')
      vim.keymap.set('n', '<F5>', "<cmd>lua require('dap').continue()<CR>")

      wk.register({
         d = {
            name = ".dap", -- optional group name
            o = { "<cmd>lua require('dapui').open()<CR>", "open dapui" },
            e = { "<cmd>lua require('dapui').close()<CR>", "close dapui" },
            p = { "<cmd>lua require('dap-python').test_method()<CR>", "debug python" },
            b = { "<cmd>DapToggleBreakpoint<CR>", "breakpoint" },
            i = { "<cmd>DapStepInto<CR>", "step into" },
            m = { "<cmd>lua require('dap-python').test_method()<CR>", "test method" },
            l = { "<cmd>lua require('dap-python').test_class()<CR>", "test class" },
            n = { "<cmd>DapStepOver<CR>", "step over" },
            t = { "<cmd>DapTerminate<CR>", "dap terminate" },
            s = { "<cmd>DapStepOut<CR>", "step out" },
            h = { ".scopes .threads .frames .up .down" },
            c = { "<cmd>lua require('dap').continue()<CR>", "continue" },
            u = { "<cmd>lua require('dap').up()<CR>", "up frame" },
            d = { "<cmd>lua require('dap').down()<CR>", "down frame" },
         },
      }, {
         prefix = "<leader>"
      })
   end
}
