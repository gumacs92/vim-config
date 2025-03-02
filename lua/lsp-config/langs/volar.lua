local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_status_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

M.lsp_config = {
    codeAction = {
        enable = true,
        kinds = {
            "quickfix",
            "source.organizeImports",
            "source.addImport",
            "source.fixAll", 
            "source.removeUnusedImports"
        },
    },
    capabilities = capabilities,
    filetypes = { "vue" },
    on_attach = function(client, bufnr)
        vim.notify("Volar LSP attached", vim.log.levels.INFO)
    end,
}

M.linters = {}
M.formatters = { "prettierd" }

function M.setup_lsp()
    return M.lsp_config
end

function M.setup_linters()
    return M.linters
end

function M.setup_formatters()
    return M.formatters
end

return M
