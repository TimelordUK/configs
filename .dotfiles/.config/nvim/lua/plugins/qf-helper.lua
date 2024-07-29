return {
   "stevearc/qf_helper.nvim",
   config = function()
      require("qf_helper").setup()
      local wk = require("which-key")
      wk.add({
         { "<leader>q",  group = ".qf helper" },
         { "<leader>ql", "<cmd>LLToggle!<CR>", desc = "ll toggle" },
         { "<leader>qn", "<cmd>QNext<CR>",     desc = "next quickfix" },
         { "<leader>qp", "<cmd>QPrev<CR>",     desc = "prev quickfix" },
         { "<leader>qq", "<cmd>QFToggle!<CR>", desc = "qf toggle" },
      })
   end,
}
