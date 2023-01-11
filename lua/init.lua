
local telescope = require"telescope"
local trouble = require"trouble"
local lualine = require'lualine'
local autosession = require'auto-session' -- saveing session automatically during folder change
local lsp_lines =  require"lsp_lines" -- diagnostic text lines are much more prettier
local pqf = require"pqf" -- prettier quickfix list


-- Vim quickfix reflector config
vim.g.qf_modifiable = 1
vim.g.qf_join_changes = 1
vim.g.qf_write_changes = 1

-- Prettier quick fix list setup
pqf.setup()

-- Diagnostic lines setup and config
lsp_lines.setup()

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = true
})


-- Configuring Telescope plugin
telescope.setup {
	defaults = {
		mappings = {
			i = { ["<C-t>"] = trouble.open_with_trouble },
			n = { ["<C-t>"] = trouble.open_with_trouble },
		},
	},
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
telescope.load_extension('project')
telescope.load_extension "file_browser"
telescope.load_extension("session-lens")

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
vim.api.nvim_set_keymap(
	'n',
	'<leader>ff',
	":Telescope live_grep<CR>",
	{noremap = true, silent = true}
)

require('autocomplete')


lualine.setup {
	sections = {
		lualine_c = {
			require('auto-session-library').current_session_name
		}
	}
}
autosession.setup {
	-- auto_session_enable_last_session = true,
	-- log_level = 'debug',
	-- auto_save_enabled = true,
	-- auto_restore_enabled = true,
	auto_session_allowed_dirs = { '/home/gumacs/dev/*' },
	cwd_change_handling = {
		restore_upcoming_session = true,
		post_cwd_changed_hook = function ()
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
