
local telescope = require"telescope"
local trouble = require"trouble"
local lualine = require'lualine'
local autosession = require'auto-session' -- saveing session automatically during folder change
local lsp_lines =  require"lsp_lines" -- diagnostic text lines are much more prettier
local pqf = require"pqf" -- prettier quickfix list
local tmux = require"tmux"
local nvim_autopairs = require"nvim-autopairs"
local nvim_autotag = require"nvim-ts-autotag"
local nvim_tree = require"nvim-tree"

vim.g['loaded_netrw'] = 1
vim.g['loaded_netrwPlugin'] = 1
vim.opt.termguicolors = true

nvim_tree.setup {
	sync_root_with_cwd = true
}

nvim_autopairs.setup()
nvim_autotag.setup()
tmux.setup()

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
		-- history = {
		-- 	path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
		-- 	limit = 100,
		-- }
	},
	extensions = {
		project = {
			base_dirs = {
				'~/dev',
			},
			theme = "dropdown",
			order_by = "asc",
			sync_with_nvim_tree = true, -- default false
		},
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		}
	}
}

-- Loading Telescope extensions
-- telescope.load_extension('smart_history')
telescope.load_extension('fzf')
telescope.load_extension('project')
telescope.load_extension("session-lens")

-- Setting up Keybindings for lua configured plugins
vim.api.nvim_set_keymap( "n", "<leader>eo", ":NvimTreeFocus<CR>", { noremap = true })
vim.api.nvim_set_keymap( "n", "<leader>ef", ":NvimTreeFindFile<CR>", { noremap = true })
vim.api.nvim_set_keymap( 'n', '<leader>p', ":lua require'telescope'.extensions.project.project{}<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap( 'n', '<leader>s', ":lua require('session-lens').search_session()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap( 'n', '<C-p>', ":lua require'telescope.builtin'.find_files({ignore=true,hidden=true,find_command=rg})<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap( 'n', '<leader>ff', ":lua require'telescope.builtin'.live_grep({ignore=true,hidden=true,find_command=rg})<CR>", {noremap = true, silent = true})

require ('formatter-config')
require ('autocomplete-config')

lualine.setup {
	sections = {
		lualine_c = {
			require('auto-session-library').current_session_name,
            'filename'
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
