
local M = {}


M.setup = function()
-- " inoremap <ESC> <NOP>
-- " nnoremap <C-P> :FZF<CR>
-- " nnoremap <silent> <C-p> :Files<CR>
-- " nnoremap <silent> <C-f> :Ag<Cr>

vim.api.nvim_set_keymap("n", "<leader>q", ':BufDel!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cq", ':BufDelOther!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>aq", ':BufDelAll!<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "o", "o<esc><S-v>=", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "O", "O<esc><S-v>=", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<Del>", "c", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<BS>", "c", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-j>", "30<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "30<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-h>", "30<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "30<C-w>l", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>lf", ':lua formatCode()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>ff", ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fb", ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fh", ':Telescope help_tags<CR>F', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "f", "<Plug>Sneak_f", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "F", "<Plug>Sneak_F", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "t", "<Plug>Sneak_t", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "T", "<Plug>Sneak_T", { noremap = true, silent = true })

end


return M
