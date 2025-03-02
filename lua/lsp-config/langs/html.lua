local M = {}

M.lsp_config = {}
M.linters = {}
M.formatters = {}

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
