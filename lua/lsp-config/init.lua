local masonLspConfig = require "mason-lspconfig"
local lspconfig = require('lspconfig')
local lspSage = require('lspsaga')

local mappings = require('lsp-config.mappings')

local M = {}

M.setup = function(ensure_installed, configs, capabilities)
    -- Configuring mason
    masonLspConfig.setup {
        ensure_installed = ensure_installed,
        automatic_installation = true
    }

    local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
    }

    local on_attach = mappings.setup()

    -- Add additional capabilities supported by nvim-cmp
    for _, lspServer in ipairs(ensure_installed) do
        local setupObject = {
            -- on_attach = my_custom_on_attach,
            flags = lsp_flags,
            on_attach = on_attach,
            capabilities = capabilities,
        }
        if configs[lspServer] then
            for key, value in pairs(configs[lspServer]) do
                -- print("Preparing setup object" .. " " .. lspServer .. " " .. key)
                setupObject[key] = value
            end
        end
        -- for key, _ in pairs(setupObject) do
        -- print("Setting up " .. " " .. lspServer .. " " .. key)
        -- end
        lspconfig[lspServer].setup(setupObject)
    end

    -- Setup lspsaga
    lspSage.setup {
        code_action = {
            extend_gitsigns = true,
            keys = {
                quit = '<ESC>',
                exec = '<CR>'
            }
        },
        definition = {
            keys = {
                quite = '<ESC>',
            }
        }
    }
end


return M
