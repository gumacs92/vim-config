require('auto-session').setup({
	auto_session_enabled = true,
	auto_session_enable_last_session = true
})
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
require'telescope'.load_extension('project')
require("telescope").load_extension "file_browser"
require("telescope").load_extension("session-lens")
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

print "Sourced init.lua"
