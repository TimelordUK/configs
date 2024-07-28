return {
   "romgrk/barbar.nvim",
   dependencies = {
      "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
   },
   --   init = function() vim.g.barbar_auto_setup = false end,
   config = function()
      local wk = require("which-key")

      wk.add(
         {
            -- Move to previous/next
            { "<A-,>", "<Cmd>BufferPrevious<CR>",     desc = "goto prev buffer" },
            { "<A-.>", "<Cmd>BufferNext<CR>",         desc = "goto next buffer" },
            { "<A-0>", "<Cmd>BufferLast<CR>",         desc = "goto last buffer" },
            -- Goto buffer in position...
            { "<A-1>", "<Cmd>BufferGoto 1<CR>",       desc = "goto buffer 1" },
            { "<A-2>", "<Cmd>BufferGoto 2<CR>",       desc = "goto buffer 2" },
            { "<A-3>", "<Cmd>BufferGoto 3<CR>",       desc = "goto buffer 3" },
            { "<A-4>", "<Cmd>BufferGoto 4<CR>",       desc = "goto buffer 4" },
            { "<A-5>", "<Cmd>BufferGoto 5<CR>",       desc = "goto buffer 5" },
            { "<A-6>", "<Cmd>BufferGoto 6<CR>",       desc = "goto buffer 6" },
            { "<A-7>", "<Cmd>BufferGoto 7<CR>",       desc = "goto buffer 7" },
            { "<A-8>", "<Cmd>BufferGoto 8<CR>",       desc = "goto buffer 8" },
            { "<A-9>", "<Cmd>BufferGoto 9<CR>",       desc = "goto buffer 9" },
            -- Re-order to previous/next
            { "<A-<>", "<Cmd>BufferMovePrevious<CR>", desc = "move buffer left" },
            { "<A->>", "<Cmd>BufferMoveNext<CR>",     desc = "move buffer right" },
            -- Close buffer
            { "<A-c>", "<Cmd>BufferClose<CR>",        desc = "close buffer" },
            -- Pin/unpin buffer
            { "<A-p>", "<Cmd>BufferPin<CR>",          desc = "toggle pin buffer" },
            -- Magic buffer-picking mode
            { "<C-p>", "<Cmd>BufferPick<CR>",         desc = "magic buffer pick" },
         }
      )
      -- Close commands
      wk.add(
         {
            { "<leader>c",  group = ".barbar close" },
            { "<leader>ca", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", desc = "kill all but curr/pin buf" },
            { "<leader>cc", "<cmd>BufferCloseAllButCurrent<CR>",         desc = "kill all but curr buf" },
            { "<leader>cl", "<cmd>BufferCloseBuffersLeft<CR>",           desc = "kill all left" },
            { "<leader>cr", "<cmd>BufferCloseBuffersRight<CR>",          desc = "kill all right" },
            { "<leader>cw", "<cmd>BufferWipeout<CR>",                    desc = "wipeout current" },
         }
      )

      -- scroll commands
      wk.add(
         {
            { "ss",  group = ".barbar scroll" },
            { "ssl", "<cmd>BufferScrollLeft<CR>",  desc = "scroll left" },
            { "ssr", "<cmd>BufferScrollRight<CR>", desc = "scroll right" },
         }
      )

      -- Sort automatically by...
      wk.add(
         {
            { "<Space>b",  group = ".barbar sort" },
            { "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", desc = "sort by buffer num" },
            { "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>",    desc = "sort by directory" },
            { "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>",     desc = "sort by language" },
            { "<Space>bn", "<Cmd>BufferOrderByName<CR>",         desc = "sort by name" },
            { "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", desc = "sort by window num" },
         }
      )

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
