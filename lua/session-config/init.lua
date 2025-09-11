local possession = require("possession")

local M = {}

M.setup = function()
    -- Helper: extract the project name if cwd is under ~/dev
    local function get_project()
        local cwd = vim.fn.getcwd()
        local dev_prefix = os.getenv("HOME") .. "/dev/"

        print('CWD: ' .. cwd, 'DEV_PREFIX: ' .. dev_prefix)
        if cwd:sub(1, #dev_prefix) == dev_prefix then
            -- Extract only the first folder name after ~/dev/
            return cwd:sub(#dev_prefix + 1):match("([^/]+)")
        end
        return nil
    end

    print('Init session')
    possession.setup {
        session_dir = vim.fn.stdpath("data") .. "/sessions",
        autosave = {
            current = false,
            cwd = false,
            tmp = false,
            on_load = true,
            on_quit = true
        },
        autoload = 'last_cwd',
        silent = true,
    }
end

return M
