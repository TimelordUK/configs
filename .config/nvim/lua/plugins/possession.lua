return
{
   "gennaro-tedesco/nvim-possession",
   dependencies = {
      "ibhagwan/fzf-lua",
   },
   config = function()
      local possession = require("nvim-possession")
      possession.setup(
      {
         commands = {
            save = 'PossessionSave',
            load = 'PossessionLoad',
            rename = 'PossessionRename',
            close = 'PossessionClose',
            delete = 'PossessionDelete',
            show = 'PossessionShow',
            list = 'PossessionList',
            migrate = 'PossessionMigrate',
         }
      })

      vim.keymap.set("n", "<leader>sl", function()
         possession.list()
      end)
      vim.keymap.set("n", "<leader>sn", function()
         possession.new()
      end)
      vim.keymap.set("n", "<leader>su", function()
         possession.update()
      end)
      vim.keymap.set("n", "<leader>sd", function()
         possession.delete()
      end)
   end,
}
