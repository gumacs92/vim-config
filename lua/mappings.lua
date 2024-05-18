local siblingSwap = require('sibling-swap')

local M = {}

M.setup = function()
    -- " inoremap <ESC> <NOP>
    -- " nnoremap <C-P> :FZF<CR>
    -- " nnoremap <silent> <C-p> :Files<CR>
    -- " nnoremap <silent> <C-f> :Ag<Cr>
    --
    --

    vim.keymap.set("n", "<leader>q", function() vim.cmd('BufDel!') end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>cq", ':BufDelOther!<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>aq", ':BufDelAll!<CR>', { noremap = true, silent = true })

    vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })

    vim.keymap.set("n", "o", "o<esc><S-v>=", { noremap = true, silent = true })
    vim.keymap.set("n", "O", "O<esc><S-v>=", { noremap = true, silent = true })

    vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { noremap = true, silent = true })
    vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { noremap = true, silent = true })
    vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
    vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
    vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
    vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

    vim.keymap.set("v", "<Del>", "c", { noremap = true, silent = true })
    vim.keymap.set("v", "<BS>", "c", { noremap = true, silent = true })

    vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-S-j>", "<C-w>-", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-S-k>", "<C-w>+", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-S-h>", "<C-w><", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-S-l>", "<C-w>>", { noremap = true, silent = true })


    vim.keymap.set("n", "<leader>lf", ':lua formatCode()<CR>', { noremap = true, silent = true })

    vim.keymap.set("n", "<leader>ff", ':Telescope find_files<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fg", ':Telescope live_grep<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fb", ':Telescope buffers<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fh", ':Telescope help_tags<CR>F', { noremap = true, silent = true })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

    siblingSwap.setup({
        keymaps = {
            ['<M-l>'] = 'swap_with_right',
            ['<M-h>'] = 'swap_with_left',
            ['<space>l'] = 'swap_with_right_with_opp',
            ['<space>h'] = 'swap_with_left_with_opp',
        },
    })
end


return M
