return
{
   'stevearc/aerial.nvim',
   opts = {},
   -- Optional dependencies
   dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
   },
   config = function()
      require('aerial').setup()
      vim.keymap.set('n', '<leader>ao', '<cmd>AerialOpen<cr>')
      vim.keymap.set('n', '<leader>ac', '<cmd>AerialClose<cr>')
   end
}
