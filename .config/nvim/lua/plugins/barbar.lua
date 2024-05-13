return
{
   'romgrk/barbar.nvim',
   dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
   },
--   init = function() vim.g.barbar_auto_setup = false end,
   config = function()
      local map = vim.api.nvim_set_keymap
      local options = { noremap = true, silent = true }

      -- Move to previous/next
      map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', options)
      map('n', '<A-.>', '<Cmd>BufferNext<CR>', options)
      -- Re-order to previous/next
      map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', options)
      map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', options)
      -- Goto buffer in position...
      map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', options)
      map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', options)
      map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', options)
      map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', options)
      map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', options)
      map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', options)
      map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', options)
      map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', options)
      map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', options)
      map('n', '<A-0>', '<Cmd>BufferLast<CR>', options)
      -- Pin/unpin buffer
      map('n', '<A-p>', '<Cmd>BufferPin<CR>', options)
      -- Close buffer
      map('n', '<A-c>', '<Cmd>BufferClose<CR>', options)
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseAllButCurrentOrPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight
      -- Magic buffer-picking mode
      map('n', '<C-p>', '<Cmd>BufferPick<CR>', options)
      -- Sort automatically by...
      map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', options)
      map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', options)
      map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', options)
      map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', options)
      map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', options)

      -- Other:
      -- :BarbarEnable - enables barbar (enabled by default)
      -- :BarbarDisable - very bad command, should never be used
   end
}

