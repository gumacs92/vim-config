
local formatter = require"formatter"

local M = {}

M.setup = function ()
    formatter.setup {
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
            typescript = { require("formatter.filetypes.typescript").prettier },
            typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
            javascript = { require("formatter.filetypes.javascript").prettier },
            javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
            json  = { require("formatter.filetypes.json").prettier },
            css = { require("formatter.filetypes.css").prettier },
            vue = { require("formatter.filetypes.typescript").eslint_d },
            php = { require("formatter.filetypes.php").php_cs_fixer },

            -- Use the special "*" filetype for defining formatter configurations on
            -- any filetype
            ["*"] = {
                -- "formatter.filetypes.any" defines default configurations for any
                -- filetype
                require("formatter.filetypes.any").remove_trailing_whitespace
            }
        }
    }
end

return M
