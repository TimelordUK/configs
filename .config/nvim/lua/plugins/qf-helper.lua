return {
   'stevearc/qf_helper.nvim',
   config = function()
      require 'qf_helper'.setup()
      local silent = { silent = true }

      vim.keymap.set('n', '<leader>qn', '<cmd>QNext<CR>', silent)
      vim.keymap.set('n', '<leader>qp', '<cmd>QPrev<CR>', silent)

      --  toggle the quickfix open/closed without jumping to it

      vim.keymap.set('n', '<leader>q', '<cmd>QFToggle!<CR>', silent)
      vim.keymap.set('n', '<leader>l', '<cmd>LLToggle!<CR>', silent)
   end
}
