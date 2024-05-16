return
{
   'mrcjkb/rustaceanvim',
   version = '^4', -- Recommended
   lazy = false,  -- This plugin is already lazy
   config = function()
      vim.g.rustaceanvim = function()
         -- Update this path
         local extension_path = '/home/me/.vscode-server/extensions/vadimcn.vscode-lldb-1.10.0/'
         local codelldb_path = extension_path .. 'adapter/codelldb'
         local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
            -- The liblldb extension is .so for Linux and .dylib for MacOS
         local cfg = require('rustaceanvim.config')
         return {
            dap = {
               adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
            },
         }
      end
   end
}
