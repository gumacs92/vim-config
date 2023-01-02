
-- Configuring Telescope plugin
require('telescope').setup {
	extensions = {
		project = {
			base_dirs = {
				'~/dev',
			},
			theme = "dropdown",
			order_by = "asc",
			sync_with_nvim_tree = true, -- default false
		}
	}
}
-- Loading Telescope extensions
require'telescope'.load_extension('project')
require("telescope").load_extension "file_browser"
require("telescope").load_extension("session-lens")

-- Setting up Keybindings for lua configured plugins
vim.api.nvim_set_keymap(
  "n",
  "<leader>e",
  ":Telescope file_browser<CR>",
  { noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>p',
	":lua require'telescope'.extensions.project.project{}<CR>",
	{noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>s',
	":lua require('session-lens').search_session()<CR>",
	{noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
	'n',
	'<C-p>',
	":Telescope find_files<CR>",
	{noremap = true, silent = true}
)

require('autocomplete')


local lualine = require('lualine')
lualine.setup {
	sections = {
		lualine_c = {
			require('auto-session-library').current_session_name
		}
	}
}
local autosession = require'auto-session'
autosession.setup {
	-- auto_session_enable_last_session = true,
	-- log_level = 'debug',
	-- auto_save_enabled = true,
	-- auto_restore_enabled = true,
	auto_session_allowed_dirs = { '/home/gumacs/dev/*' },
	cwd_change_handling = {
		restore_upcoming_session = true,
		post_cwd_changed_hook = function ()
				print('hello session change')
				lualine.refresh()
		end
	}
}
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- Configuring the rmagatti/auto-session
-- require('auto-session').setup({
-- 	log_level = 'debug',
-- 	auto_session_enabled = true,
-- 	auto_save_enabled = true,
-- 	auto_restore_enabled = true,
-- })


print "Sourced init.lua"
