return
{
   "folke/which-key.nvim",
   event = "VeryLazy",
   init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
   end,
   config = function()
      local wk = require('which-key')
      wk.setup()
      wk.register({
         ["<leader>f"] = {
            name = "+file",
            f = { "<cmd>Telescope find_files<cr>", "Find File" },
            r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
            n = { "<cmd>enew<cr>", "New File" },
         },
      })
   end,
   opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
   }
}
