local siblingSwap = require('sibling-swap')
local harpoon = require('harpoon')

local M = {}

M.setup = function()
    -- vim.keymap.set("n", "<leader>lf", ':lua formatCode()<CR>', { noremap = true, silent = true })

    vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })
    vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })

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
    vim.keymap.set("n", "<M-j>", "<C-w>-", { noremap = true, silent = true })
    vim.keymap.set("n", "<M-k>", "<C-w>+", { noremap = true, silent = true })
    vim.keymap.set("n", "<M-h>", "<C-w><", { noremap = true, silent = true })
    vim.keymap.set("n", "<M-l>", "<C-w>>", { noremap = true, silent = true })



    vim.keymap.set("n", "<leader>ff", ':Telescope find_files<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fg", ':Telescope live_grep<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fb", ':Telescope buffers<CR>', { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>fh", ':Telescope help_tags<CR>F', { noremap = true, silent = true })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

    -- tabby mappings
    vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true })
    -- move current tab to previous position
    vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
    -- move current tab to next position
    vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })


    -- Harpoon mappings
    vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-S-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-S-j>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-S-k>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-S-l>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-p>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-n>", function() harpoon:list():next() end)

    siblingSwap.setup({
        keymaps = {
            ['<space>l'] = 'swap_with_right',
            ['<space>h'] = 'swap_with_left',
            -- ['<space>l'] = 'swap_with_right_with_opp',
            -- ['<space>h'] = 'swap_with_left_with_opp',
        },
    })


    local goto_prev_window = function()
        local wnr = vim.fn.winnr('#') -- Get the window number of the previous window
        local winid = vim.fn.win_getid(wnr)
        -- print(winid)
        local wininfo = vim.fn.getwininfo(winid) or {} -- Get the window info of the previous window

        -- print(vim.inspect(wininfo))

        local is_quickfix = wininfo[1].quickfix == 1 or false
        -- print(is_quickfix)
        if (winid == 0 or is_quickfix) then
            for wnr = 1, vim.fn.winnr('$') do
                winid = vim.fn.win_getid(wnr)
                -- print(winid)
                is_quickfix = vim.fn.getwininfo(winid)[1].quickfix == 1
                -- print(is_quickfix)

                -- Check if this window is NOT a quickfix window
                if not is_quickfix then
                    -- Go to that window
                    -- print("Overwriting" .. winid)
                    vim.fn.win_gotoid(winid)
                    -- Then load our newly created buffer into it
                    -- vim.cmd("buffer " .. buf)
                    break
                end
            end
        end
        -- print("Going to window 1" .. winid)
        vim.fn.win_gotoid(winid)
    end

    local get_jump_target_from_qf = function()
        local current_line = vim.fn.line('.')
        local qflist = vim.fn.getqflist()
        local current_entry = qflist[current_line]

        -- print('Current line ' .. vim.inspect(current_line))
        -- print(vim.inspect(current_entry))

        goto_prev_window()
        local buf = 0
        if bufnr == 0 then
            -- print("Buffer does not exist" .. current_entry.bufnr)
            buf = vim.fn.bufnr(current_entry.bufnr, true)
            vim.bo[buf].buflisted = true
        else
            -- print("Buffer exists" .. current_entry.bufnr)
            buf = current_entry.bufnr
        end

        return {
            buf = buf,
            lnum = current_entry.lnum,
            col = current_entry.col,
        }
    end

    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'qf',
        callback = function()
            vim.keymap.set('n', '<CR>', function()
                local target = get_jump_target_from_qf()

                vim.cmd("buffer " .. target.buf)
                vim.fn.cursor(target.lnum, target.col)
            end, { buffer = true, silent = true, noremap = true })

            vim.keymap.set("n", "<C-v>", function()
                local target = get_jump_target_from_qf()

                vim.cmd("vsplit")
                vim.cmd("buffer " .. target.buf)
                vim.fn.cursor(target.lnum, target.col)
            end, { buffer = true, noremap = true, silent = true })
        end,
    })
end


return M
