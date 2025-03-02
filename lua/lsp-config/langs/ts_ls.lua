local M = {}

M.lsp_config = {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          languages = { "javascript", "typescript", "vue" },
          location = vim.fn.stdpath('config') .. "/node_modules/@vue/typescript-plugin",
        },
      },
    },
    filetypes = {
      "javascript",
      "typescript",
      "vue",
      "typescriptreact",
      "javascriptreact",
    },
    on_attach = function(client, bufnr)
      local tsUtils = require('nvim-lsp-ts-utils')
      tsUtils.setup {
        auto_inlay_hints = true,
        inlay_hints_highlight = "Comment",
        enable_import_on_completion = true,
      }
      tsUtils.setup_client(client)
    end
}

M.linters = { "eslint_d" }
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
