require("config.options")
-- require("config.mappings")
require("config.autocmds")
require("config.lazy")
vim.opt.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
