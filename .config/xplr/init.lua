version = '0.21.7'
package.path = os.getenv("LUA_PATH") .. ";" .. package.path
package.cpath = os.getenv("LUA_CPATH") .. ";" .. package.cpath

xplr.config.general.show_hidden = true

local home = os.getenv("HOME")
package.path = home
.. "/.config/xplr/plugins/?/init.lua;"
.. home
.. "/.config/xplr/plugins/?.lua;"
.. package.path

local map = require("map")
map.setup{
  mode = "default",  -- or `xplr.config.modes.builtin.default`
  key = "M",
  editor = os.getenv("EDITOR") or "vim",
  editor_key = "ctrl-o",
  prefer_multi_map = false,
  placeholder = "{}",
  spacer = "{_}",
  custom_placeholders = map.placeholders,
}

-- Type `M` to switch to single map mode.
-- Then press `tab` to switch between single and multi map modes.
-- Press `ctrl-o` to edit the command using your editor.

require("zoxide").setup{
  bin = "zoxide",
  mode = "default",
  key = "Z",
}

-- Type `Z` to spawn zoxide prompt.

require"icons".setup()



