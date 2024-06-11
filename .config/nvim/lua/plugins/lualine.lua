return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local lualine = require("lualine")
		local lsp = function()
			local msg = "No Active Lsp"
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return msg
			end
			local num = vim.fn.bufnr("%")
			for _, client in ipairs(clients) do
				local buffers = client.attached_buffers
				if buffers[num] then
					return client.name
				end
			end
			return msg
		end

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		local lst = {
			lsp,
			icon = " LSP:",
			cond = conditions.buffer_not_empty,
		}

		local name = function()
			return vim.fn.fnamemodify(vim.v.this_session, ":t")
		end

		local session = {
			name,
			cond = conditions.buffer_not_empty,
		}

		local config = {
			options = { theme = "gruvbox" },
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics", "selectioncount" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype", "filesize" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		}

		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		ins_left(lst)
		ins_left(session)

		-- ins_left {
		--    'v:this_session',
		--    cond = conditions.buffer_not_empty,
		--    color = { gui = 'bold' },
		-- }
		lualine.setup(config)
	end,
}
