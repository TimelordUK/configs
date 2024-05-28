return
{
   'mfussenegger/nvim-dap-python',
   opts = {},
   config = function()
      require('dap-python').setup('~/miniconda3/envs/krypton/bin/python')
   end
   -- Optional dependencies
}
