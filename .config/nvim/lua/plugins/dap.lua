return
{
   'mfussenegger/nvim-dap',
   config = function()
      local dap = require('dap')
     -- dap.adapters.executable = {
     --    type = 'executable',
     --    command = '/home/me/.vscode-server/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb',
     --    name = 'lldb1',
     --    host = '127.0.0.1',
     --    port = 13000
     -- }
     --
     -- dap.adapters.lldb = {
     --    type = 'executable',
     --    command = '/home/me/.vscode-server/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb', -- adjust as needed, must be absolute path
     --    name = 'lldb',
     --    args = { "--port", "13000" },
     -- }
   end
}
