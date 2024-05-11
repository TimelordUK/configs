return {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.6",
      dependencies = { "nvim-lua/plenary.nvim" },
      init = function()
         local builtin = require("telescope.builtin")
         local themes = require('telescope.themes')
         vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
         vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
         vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
         vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
         vim.keymap.set("n", "<leader>fc", function() builtin.current_buffer_fuzzy_find({layout_strategy='vertical',layout_config={width=0.9}}) end,{})
      end
}
