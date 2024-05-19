return
{
   'natecraddock/sessions.nvim',
   config = function()
      local sessions = require('sessions')
      sessions.setup({
         events = { "VimEnter" },
         session_filepath = vim.fn.stdpath("data") .. "/sessions",
         absolute = true,
      })
      sessions.stop_autosave()

      _G.sessions_wrap_save = function(opts)
         local ss = require('sessions')
         opts = opts or {}
         local s = vim.v.this_session
         print(s)
         ss.save(s)
      end
      vim.keymap.set("n", "<leader>ss", "<cmd>lua _G.sessions_wrap_save()<CR>") -- We can also send call options directly
   end
}
