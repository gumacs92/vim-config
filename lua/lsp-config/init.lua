local masonLspConfig = require "mason-lspconfig"
local lspconfig = require('lspconfig')
local lspSage = require('lspsaga')
local ufo = require('ufo')
-- local origami = require("origami")

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

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    -- for _, ls in ipairs(language_servers) do
    --     require('lspconfig')[ls].setup({
    --         capabilities = capabilities
    --         -- you can add other fields for setting up lsp server in this table
    --     })
    -- end

    -- Add additional capabilities supported by nvim-cmp
    for _, lspServer in ipairs(ensure_installed) do
        local setupObject = {
            flags = lsp_flags,
            on_attach = function(client, bufnr)
                if lspServer.on_attach then
                    lspServer.on_attach(client, bufnr)
                end
                mappings.setup()(client, bufnr)
            end,
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


    ufo.setup({
        -- provider_selector = function(bufnr, filetype, buftype)
        --     return { 'treesitter', 'indent' }
        -- end,
        enable_get_fold_virt_text = true,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, 'MoreMsg' })
            return newVirtText
        end
    })
    --
    -- origami.setup {
    -- 	keepFoldsAcrossSessions = true,
    -- 	pauseFoldsOnSearch = true,
    -- 	setupFoldKeymaps = true,
    -- }
    --
end


return M
