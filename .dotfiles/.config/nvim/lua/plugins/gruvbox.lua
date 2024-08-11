return {
   'ellisonleao/gruvbox.nvim',
   config = function()
      require('lualine').setup()
      vim.opt.termguicolors = true
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd([[colorscheme gruvbox]])
   end
}
