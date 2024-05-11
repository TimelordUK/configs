return {
   {
      'ibhagwan/fzf-lua',
      -- optional for icon support
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
         -- calling `setup` is optional for customization
         require("fzf-lua").setup(
         {
            'default',
            winopts = 
            {
               fullscreen = true,
               preview = {
                  -- default     = 'bat',           -- override the default previewer?
                  -- default uses the 'builtin' previewer
                  border         = 'border',        -- border|noborder, applies only to
                  wrap           = 'wrap',        -- wrap|nowrap
                  layout         = 'flex',          -- horizontal|vertical|flex
                  -- native fzf previewers (bat/cat/git/etc)
                  vertical       = 'down:45%',      -- up|down:size
                  horizontal     = 'right:60%',     -- right|left:size
                  flip_columns   = 70,             -- #cols to switch to horizontal on flex
               },
            },
            keymap = {
               builtin = {
                  ["<F1>"]     = "toggle-help",
                  ["<F2>"]     = "toggle-fullscreen",
                  -- Only valid with the 'builtin' previewer
                  ["<F3>"]     = "toggle-preview-wrap",
                  ["<F4>"]     = "toggle-preview",
                  ["<F5>"]     = "toggle-preview-ccw",
                  ["<F6>"]     = "toggle-preview-cw",
                  ["<S-h>"]    = "preview-page-down",
                  ["<S-l>"]    = "preview-page-up",
                  ["<S-left>"] = "preview-page-reset",
               },
               fzf = {
                  ["ctrl-a"]  = "toggle-all",
                  ["alt-a"] = "beginning-of-line",
                  -- Only valid with fzf previewers (bat/cat/git/etc)
                  ["ctrl-q"] = "select-all+accept",
               }
            },
         })
         local lua="<cmd>lua require('fzf-lua')"
         local o ="({ resume = true })<CR>"
         local silent = { silent = true }

         vim.keymap.set("n", "ff", lua .. ".files({})<CR>" , silent)
         vim.keymap.set("n", "fb", lua .. ".grep_curbuf" .. o, silent)
         vim.keymap.set("n", "fo", lua .. ".files({cwd='~/.config'})<CR>", silent)
         vim.keymap.set("n", "fh", lua .. ".command_history" .. o, silent)          
         vim.keymap.set("n", "fm", lua .. ".git_commits" .. o, silent)     
         vim.keymap.set("n", "fp", lua .. ".grep_project" .. o, silent)     

         _G.fzf_dirs = function(opts)
            local fzf_lua = require'fzf-lua'
            opts = opts or {}
            opts.prompt = "Directories> "
            opts.fn_transform = function(x)
               return fzf_lua.utils.ansi_codes.magenta(x)
            end
            opts.actions = {
               ['default'] = function(selected)
                  vim.cmd("cd " .. selected[1])
               end
            }
            fzf_lua.fzf_exec("fd --hidden --type d", opts)
         end

         -- map our provider to a user command ':Directories'
         vim.cmd([[command! -nargs=* Directories lua _G.fzf_dirs()]])

         -- or to a keybind, both below are (sort of) equal
         -- vim.keymap.set('n', '<C-k>', _G.fzf_dirs)
         vim.keymap.set('n', '<C-k>', '<cmd>lua _G.fzf_dirs()<CR>')

         -- We can also send call options directly
         -- :lua _G.fzf_dirs({ cwd = <other directory> })
      end
   }
}
