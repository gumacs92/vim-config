local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_status_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

M.lsp_config = {
    init_options = {
        hostInfo = "neovim",
        preferences = {
            includeCompletionsForImportStatements = true,
            includeCompletionsForModuleExports = true,
            completeFunctionCalls = true,
        },
        plugins = {
            {
                name = "@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
                location = vim.fn.stdpath('config') .. "/node_modules/@vue/typescript-plugin",
            },
        },
    },
    capabilities = capabilities,
    filetypes = {
        "javascript",
        "typescript",
        "vue",
        "typescriptreact",
        "javascriptreact",
    },
    on_attach = function(client, bufnr)
        local ts_utils_ok, tsUtils = pcall(require, 'nvim-lsp-ts-utils')
        if ts_utils_ok then
            tsUtils.setup {
                enable_import_on_completion = true,
            }
            tsUtils.setup_client(client)
        else
            vim.notify("nvim-lsp-ts-utils is not installed", vim.log.levels.WARN)
        end
    end,
    settings = {},
}

return M
