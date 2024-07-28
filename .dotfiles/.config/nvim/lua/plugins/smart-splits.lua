return {
   "mrjones2014/smart-splits.nvim",
   config = function()
      --require('smart-splits').setupa({})
      local wk = require("which-key")
      wk.add(
         {
            { "A", group = ".resize-split" },
         }
      )
      local ss = require("smart-splits")
      wk.add(
         {
            { "<A-\\>",            ss.move_cursor_previous, desc = "move previous" },

            --resize

            { "<A-h>",             ss.resize_left,          desc = "resize left" },
            { "<A-j>",             ss.resize_down,          desc = "resize down" },
            { "<A-k>",             ss.resize_up,            desc = "resize up" },
            { "<A-l>",             ss.resize_right,         desc = "resize right" },

            --moving between splits

            { "<C-h>",             ss.move_cursor_left,     desc = "move left" },
            { "<C-j>",             ss.move_cursor_down,     desc = "move down" },
            { "<C-k>",             ss.move_cursor_up,       desc = "move up" },
            { "<C-l>",             ss.move_cursor_right,    desc = "move right" },

            --swapping buffers between windows

            { "<leader><leader>h", ss.swap_buf_left,        desc = "swap left" },
            { "<leader><leader>j", ss.swap_buf_down,        desc = "swap down" },
            { "<leader><leader>k", ss.swap_buf_up,          desc = "swap up" },
            { "<leader><leader>l", ss.swap_buf_down,        desc = "swap right" },
            { "<leader>ss",        ss.start_resize_mode,    desc = "smart resize mode" }
         })
   end,
}
