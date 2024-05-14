return {
   'ibhagwan/fzf-lua',
   -- optional for icon support
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   config = function()
      local options = {
         'default',
         winopts =
         {
            fullscreen = true,
            preview = {
               -- default     = 'bat',           -- override the default previewer?
               -- default uses the 'builtin' previewer
               border       = 'border',      -- border|noborder, applies only to
               wrap         = 'wrap',        -- wrap|nowrap
               layout       = 'flip',        -- horizontal|vertical|flex
               -- native fzf previewers (bat/cat/git/etc)
               vertical     = 'down:45%',    -- up|down:size
               horizontal   = 'right:60%',   -- right|left:size
               flip_columns = 70,            -- #cols to switch to horizontal on flex
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
               ["<A-j>"]    = "preview-page-down",
               ["<A-k>"]    = "preview-page-up",
               ["<S-left>"] = "preview-page-reset",
            },
            fzf = {
               ["ctrl-a"] = "toggle-all",
               ["alt-a"]  = "beginning-of-line",
               -- Only valid with fzf previewers (bat/cat/git/etc)
               ["ctrl-q"] = "select-all+accept",
            }
         },
      }
      -- calling `setup` is optional for customization
      require("fzf-lua").setup(options)

      local lua = "<cmd>lua require('fzf-lua')"
      local resume_option = "({ resume = true })<CR>"
      local silent = { silent = true }

      _G.fzf_fb = function()
         local fzf = require('fzf-lua')
         fzf.setup()
         local opts = {
            winopts = {
               fullscreen = true,
               preview = {
                  layout   = 'vertical',
                  vertical = 'up:55%',
               }
            },
            keymap = {
               builtin = {
                  ["<A-j>"]    = "preview-page-down",
                  ["<A-k>"]    = "preview-page-up",
                  ["<S-left>"] = "preview-page-reset",
               },
               fzf = {
                  ["ctrl-a"] = "toggle-all",
                  ["alt-a"]  = "beginning-of-line",
                  -- Only valid with fzf previewers (bat/cat/git/etc)
                  ["ctrl-q"] = "select-all+accept",
               }
            }
         }
         fzf.grep_curbuf(opts)
      end

      vim.keymap.set("n", "ff", lua .. ".files({})<CR>", silent)
      vim.keymap.set("n", "fo", lua .. ".files({cwd='~/.config'})<CR>", silent)
      vim.keymap.set("n", "fh", lua .. ".command_history" .. resume_option, silent)
      vim.keymap.set("n", "fm", lua .. ".git_commits" .. resume_option, silent)
      vim.keymap.set("n", "fp", lua .. ".grep_project" .. resume_option, silent)
      vim.keymap.set("n", "fd", lua .. ".lsp_document_symbols" .. resume_option, silent)

      _G.fzf_dirs = function(opts)
         _G.fzf_cd_with("fd --hidden --type d", opts)
      end

      _G.fzf_zoxide_dirs = function(opts)
         _G.fzf_cd_with("zoxide query --list", opts)
      end

      _G.fzf_cd_with = function(command, opts)
         local fzf_lua = require 'fzf-lua'
         opts = opts or {}
         opts.prompt = "Zoxide> "
         opts.fn_transform = function(x)
            return fzf_lua.utils.ansi_codes.yellow(x)
         end
         opts.actions = {
            ['default'] = function(selected)
               vim.cmd("cd " .. selected[1])
            end
         }
         fzf_lua.fzf_exec(command, opts)
      end

      -- map our provider to a user command ':Directories'
      vim.cmd([[command! -nargs=* Directories lua _G.fzf_dirs()]])
      vim.cmd([[command! -nargs=* Zoxide lua _G.fzf_zoxide_dirs()]])
      -- or to a keybind, both below are (sort of) equal
      -- vim.keymap.set('n', '<C-k>', _G.fzf_dirs)
      vim.keymap.set('n', '<C-k>', '<cmd>lua _G.fzf_dirs()<CR>')
      vim.keymap.set('n', '<C-z>', '<cmd>lua _G.fzf_zoxide_dirs()<CR>')
      vim.keymap.set("n", "fb", '<cmd>lua _G.fzf_fb()<CR>', silent)
      -- We can also send call options directly
      -- :lua _G.fzf_dirs({ cwd = <other directory> })
   end
}
