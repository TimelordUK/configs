return {
   "kevinhwang91/nvim-ufo",
   dependencies = {
      "kevinhwang91/promise-async",
   },
   config = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local peek = function()
         local winid = require("ufo").peekFoldedLinesUnderCursor()
         if not winid then
            -- choose one of coc.nvim and nvim lsp
            vim.lsp.buf.hover()
         end
      end

      local wk = require("which-key")
      local ufo = require("ufo")
      wk.add(
         {
            { "z",  group = ".ufo" },
            { "zM", ufo.closeAllFolds,                               desc = "close all folds" },
            { "zR", ufo.openAllFolds,                                desc = "open all folds" },
            { "zm", ufo.closeFoldsWith,                              desc = "close folds with" },
            { "zo", '<cmd>lua require("ufo").closeFoldsWith(1)<CR>', desc = "fold all but 1" },
            { "zp", peek,                                            desc = "preview fold" },
         })

      -- Option 3: treesitter as a main provider instead
      -- (Note: the `nvim-treesitter` plugin is *not* needed.):w
      -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`

      local handler = function(virtText, lnum, endLnum, width, truncate)
         local newVirtText = {}
         local suffix = (" 󰁂 %d "):format(endLnum - lnum)
         local sufWidth = vim.fn.strdisplaywidth(suffix)
         local targetWidth = width - sufWidth
         local curWidth = 0
         for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
               table.insert(newVirtText, chunk)
            else
               chunkText = truncate(chunkText, targetWidth - curWidth)
               local hlGroup = chunk[2]
               table.insert(newVirtText, { chunkText, hlGroup })
               chunkWidth = vim.fn.strdisplaywidth(chunkText)
               -- str width returned from truncate() may less than 2nd argument, need padding
               if curWidth + chunkWidth < targetWidth then
                  suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
               end
               break
            end
            curWidth = curWidth + chunkWidth
         end
         table.insert(newVirtText, { suffix, "MoreMsg" })
         return newVirtText
      end

      -- global handler
      -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
      -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.

      require("ufo").setup({
         fold_virt_text_handler = handler,
         provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
         end,
      })
   end,
}
