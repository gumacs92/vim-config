local masonNullLsConfig = require"mason-null-ls"
local null_ls = require("null-ls")

local M = {}
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.setup = function(ensure_installed)
    -- Configuring mason
    masonNullLsConfig.setup {
        ensure_installed = ensure_installed,
        automatic_install = true,
    }

    null_ls.setup({
        sources = {
            null_ls.builtins.hover.printenv,
            null_ls.builtins.hover.dictionary,
            -- null_ls.builtins.completion.luasnip,
        },
         on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                            -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                            vim.lsp.buf.formatting_sync()
                        end,
                    })
                end
            end,
    })
end

return M
