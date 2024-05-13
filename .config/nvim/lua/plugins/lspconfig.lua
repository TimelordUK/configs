return {
   'neovim/nvim-lspconfig',
   config = function()
      require 'lspconfig'.lua_ls.setup {
         on_init = function(client)
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
               return
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
               runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT'
               },
               -- Make the server aware of Neovim runtime files
               workspace = {
                  checkThirdParty = false,
                  library = {
                     vim.env.VIMRUNTIME
                     -- Depending on the usage, you might want to add additional paths here.
                     -- "${3rd}/luv/library"
                     -- "${3rd}/busted/library",
                  }
                  -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                  -- library = vim.api.nvim_get_runtime_file("", true)
               }
            })
         end,
         settings = {
            Lua = {}
         }
      }

      local function start_tsserver()
         local root_files = { 'package.json', 'tsconfig.json', 'jsconfig.json' }
         local paths = vim.fs.find(root_files, { stop = vim.env.HOME })
         local root_dir = vim.fs.dirname(paths[1])

         if root_dir == nil then
            -- root directory was not found
            return
         end

         vim.lsp.start({
            name = 'tsserver',
            cmd = { 'typescript-language-server', '--stdio' },
            root_dir = root_dir,
            init_options = { hostInfo = 'neovim' },
         })
      end

      vim.api.nvim_create_autocmd('FileType', {
         pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
         desc = 'Start typescript LSP',
         callback = start_tsserver,
      })

      -- vim.api.nvim_create_autocmd('FileType', {
      --     pattern = {'lua'},
      --     desc = 'Start lua LSP',
      --     callback = start_luaserver,
      -- })
      --
      -- you can add this in your init.lua
      -- (note: diagnostics are not exclusive to LSP)

      -- Show diagnostics in a floating window
      vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

      -- Move to the previous diagnostic
      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

      -- Move to the next diagnostic
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

      local setup_bindings = function(event)
         local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = event.buf }
            vim.keymap.set(mode, lhs, rhs, opts)
         end

         -- You can find details of these function in the help page
         -- see for example, :help vim.lsp.buf.hover()

         -- Trigger code completion
         bufmap('i', '<C-Space>', '<C-x><C-o>')

         -- Display documentation of the symbol under the cursor
         bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

         -- Jump to the definition
         bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

         -- Jump to declaration
         bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

         -- Lists all the implementations for the symbol under the cursor
         bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

         -- Jumps to the definition of the type symbol
         bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

         -- Lists all the references
         bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

         -- Displays a function's signature information
         bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

         -- Renames all references to the symbol under the cursor
         bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

         -- Format current file
         bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.format()<cr>')

         -- Selects a code action available at the current cursor position
         bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
      end
      vim.api.nvim_create_autocmd('LspAttach', {
         desc = 'LSP actions',
         callback = setup_bindings
      })
   end
}
