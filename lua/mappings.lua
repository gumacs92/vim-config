local M = {}

M.setup = function()
    -- " inoremap <ESC> <NOP>
    -- " nnoremap <C-P> :FZF<CR>
    -- " nnoremap <silent> <C-p> :Files<CR>
    -- " nnoremap <silent> <C-f> :Ag<Cr>

    vim.keymap.set("n", "<leader>q", function() vim.cmd('BufDel!') end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>cq", ':BufDelOther!<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>aq", ':BufDelAll!<CR>', { noremap = true, silent = true })

    vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })

    vim.keymap.set("n", "o", "o<esc><S-v>=", { noremap = true, silent = true })
    vim.keymap.set("n", "O", "O<esc><S-v>=", { noremap = true, silent = true })

    vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
    vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
    vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
    vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
    vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
    vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

    vim.keymap.set("v", "<Del>", "c", { noremap = true, silent = true })
    vim.keymap.set("v", "<BS>", "c", { noremap = true, silent = true })

    vim.keymap.set("n", "<C-j>", "30<C-w>j", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-k>", "30<C-w>k", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-h>", "30<C-w>h", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-l>", "30<C-w>l", { noremap = true, silent = true })

    vim.keymap.set("n", "<leader>lf", ':lua formatCode()<CR>', { noremap = true, silent = true })

    vim.keymap.set("n", "<leader>ff", ':Telescope find_files<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fg", ':Telescope live_grep<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fb", ':Telescope buffers<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fh", ':Telescope help_tags<CR>F', { noremap = true, silent = true })

    vim.keymap.set("n", "f", "<Plug>Sneak_f", { noremap = true, silent = true })
    vim.keymap.set("n", "F", "<Plug>Sneak_F", { noremap = true, silent = true })
    vim.keymap.set("n", "t", "<Plug>Sneak_t", { noremap = true, silent = true })
    vim.keymap.set("n", "T", "<Plug>Sneak_T", { noremap = true, silent = true })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end


return M
