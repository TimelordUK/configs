return {
   'smoka7/hop.nvim',
   version = "*",
   opts = {
      keys = 'etovxqpdygfblzhckisuran'
   },
   config = function()
      local hop = require('hop')
      hop.setup()

      -- vim.keymap.set('', 'f', function()
      --   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      -- end, {remap=true})
      -- vim.keymap.set('', 'F', function()
      --   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      -- end, {remap=true})
      -- vim.keymap.set('', 't', function()
      --   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      -- end, {remap=true})
      -- vim.keymap.set('', 'T', function()
      --   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      -- end, {remap=true})

      vim.keymap.set('n', '<leader>hw', '<cmd>HopWord<CR>')
      vim.keymap.set('n', '<leader>hl', '<cmd>HopLine<CR>')
      vim.keymap.set('n', '<leader>hc',
         "<cmd>lua require'hop'.hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })<CR>")
   end
}
