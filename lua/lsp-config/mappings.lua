local ufo = require('ufo')

local M = {}

M.setup = function()
    -- print("Setting up mappings for LSP")
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<leader>ld', ":LspStop<CR>", opts)
    vim.keymap.set('n', '<leader>ls', ":LspStart<CR>", opts)


    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(_, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', bufopts)
        vim.keymap.set('n', 'gpd', '<cmd>Lspsaga peek_definition<cr>', bufopts)
        vim.keymap.set('n', 'gtd', '<cmd>Lspsaga goto_type_definition<cr>', bufopts)
        vim.keymap.set('n', 'gptd', '<cmd>Lspsaga peek_type_definition<cr>', bufopts)
        -- vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<cr>', bufopts)
        vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end


    vim.keymap.set('n', 'zR', ufo.openAllFolds)
    vim.keymap.set('n', 'zM', ufo.closeAllFolds)
    vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
    vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    -- vim.keymap.set('n', 'K', function()
    --     local winid = ufo.peekFoldedLinesUnderCursor()
    --     if not winid then
    --         -- choose one of coc.nvim and nvim lsp
    --         vim.cmd([[LSPsaga hover_doc]])
    --     end
    -- end)

    -- print("Mappings for LSP setup")

    return on_attach
end

return M
