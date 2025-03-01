local masonDapConfig = require "mason-nvim-dap"
local dap, dapui = require "dap", require "dapui"

local M = {}

-- We’ll define a small function to check if a file exists:
local function project_dap_config()
    local cwd = vim.fn.getcwd()
    local local_dap = cwd .. '/.nvim/dap.config.lua'
    if vim.fn.filereadable(local_dap) == 1 then
        local dap_setup = dofile(local_dap)
        if dap_setup and type(dap_setup.setup) == 'function' then
            dap_setup.setup(dap)
        end
    end
end


M.setup = function(ensure_installed)
    -- Configuring mason
    masonDapConfig.setup {
        ensure_installed = ensure_installed,
        automatic_install = true,
    }

    -- dap.setup({})

    dapui.setup({})

    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

    local dap_breakpoint = {
        error = {
            text = "🟥",
            texthl = "LspDiagnosticsSignError",
            linehl = "",
            numhl = "",
        },
        rejected = {
            text = "藖",
            texthl = "LspDiagnosticsSignHint",
            linehl = "",
            numhl = "",
        },
        stopped = {
            text = "⭐️",
            texthl = "LspDiagnosticsSignInformation",
            linehl = "DiagnosticUnderlineInfo",
            numhl = "LspDiagnosticsSignInformation",
        },
    }

    vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
    vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

    vim.keymap.set('n', "<leader>dR", function() dap.run_to_cursor() end, { desc = "Run to cursor", noremap = true })
    vim.keymap.set('n', "<leader>dE", function() dapui.eval(vim.fn.input "[Expression] > ") end,
        { desc = "Evaluate Input", noremap = true })
    vim.keymap.set('n', "<leader>dC", function() dap.set_breakpoint(vim.fn.input "[Condition] > ") end,
        { desc = "Conditional Breakpoint", noremap = true })
    vim.keymap.set('n', "<leader>dU", function() dapui.toggle() end, { desc = "Toggle UI", noremap = true })
    vim.keymap.set('n', "<leader>db", function() dap.step_back() end, { desc = "Step Back", noremap = true })
    vim.keymap.set('n', "<leader>dc", function() dap.continue() end, { desc = "Continue", noremap = true })
    vim.keymap.set('n', "<leader>dd", function() dap.disconnect() end, { desc = "Disconnect", noremap = true })
    vim.keymap.set('n', "<leader>de", function() dapui.eval() end, { desc = "Evaluate", noremap = true })
    vim.keymap.set('n', "<leader>dg", function() dap.session() end, { desc = "Get Session", noremap = true })
    vim.keymap.set('n', "<leader>dh", function() require("dap.ui.widgets").hover() end,
        { desc = "Hover Variables", noremap = true })
    vim.keymap.set('n', "<leader>dS", function() require("dap.ui.widgets").scopes() end,
        { desc = "Scopes", noremap = true })
    vim.keymap.set('n', "<leader>di", function() dap.step_into() end, { desc = "Step Into", noremap = true })
    vim.keymap.set('n', "<leader>do", function() dap.step_over() end, { desc = "Step Over", noremap = true })
    vim.keymap.set('n', "<leader>dp", function() dap.pause.toggle() end, { desc = "Pause", noremap = true })
    vim.keymap.set('n', "<leader>dq", function() dap.close() end, { desc = "Quit", noremap = true })
    vim.keymap.set('n', "<leader>dr", function() dap.repl.toggle() end,
        { desc = "Toggle REPL", noremap = true })
    vim.keymap.set('n', "<leader>ds", function() dap.continue() end, { desc = "Start", noremap = true })
    vim.keymap.set('n', "<leader>dt", function() dap.toggle_breakpoint() end,
        { desc = "Toggle Breakpoint", noremap = true })
    vim.keymap.set('n', "<leader>dx", function() dap.terminate() end, { desc = "Terminate", noremap = true })
    vim.keymap.set('n', "<leader>du", function() dap.step_out() end, { desc = "Step Out", noremap = true })

    --
    dap.set_log_level("TRACE")
    dap.adapters.php = {
        type = 'executable',
        command = 'php-debug-adapter', -- Replace with the path to your PHP debug adapter executable
        args = {}
    }
    dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = {
            os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js",
            '--trace'
        },
    }
    dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
            command = "js-debug-adapter",
            -- 💀 Make sure to update this path to point to your installation
            args = { "${port}" },
        }
    }


    dap.configurations.php = {
        {
            name = 'Launch file',
            type = 'php',
            request = 'launch',
            program = '${file}',
            cwd = '${workspaceFolder}',
            port = 9003, -- Ensure this matches your XDebug configured port
        },
        {
            name = 'Listen for XDebug',
            type = 'php',
            request = 'attach',
            port = 9004,                             -- Ensure this matches your XDebug configured port
            pathMappings = {
                ['/backend'] = '${workspaceFolder}', -- Map the remote path on the server to your local workspace path
            }
        }
    }
    dap.configurations.typescript = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            cwd = "${workspaceFolder}",
            runtimeArgs = {
                "--loader",
                "ts-node/esm"
            },
            outDir = "${workspaceFolder}/dist",
            runtimeExecutable = "node",
            args = {
                "${file}"
            },
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = {
                "<node_internals>/**",
                "node_modules/**"
            },
            resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**"
            }
        },
        {
            type = "pwa-node",
            request = "attach",
            name = 'Attach to process',
            cwd = "${workspaceFolder}/src",
            restart = true,
            sourceMaps = true,
            localRoot = "${workspaceFolder}/src",
            remoteRoot = "/usr/src/app",
            skipFiles = {
                "<node_internals>/**",
                "node_modules/**"
            },
            on_attach = function(session, body)
                -- print("cwd: ", session.config.cwd)
                print("workspaceFolder: ", vim.fn.getcwd())
            end,
            resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**"
            },
            trace = true,
            -- outFiles = { "${workspaceFolder}/dist/**/*.js" }
            outDir = "${workspaceFolder}/dist"
        },
    }
    dap.configurations.javascript = {
        {
            name = 'Launch file',
            type = 'node2',
            request = 'launch',
            program = '${file}',
            cwd = '${workspaceFolder}',
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            -- For this to work you need to make sure the node process is started with the `--inspect` flag.
            name = 'Attach to process',
            type = 'node2',
            request = 'attach',
            processId = require 'dap.utils'.pick_process,
        },
    }


    -- Run this function automatically on VimEnter or DirChanged
    -- so that it picks up the correct config when you switch projects.
    vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
        callback = function()
            project_dap_config()
        end,
    })
end

return M
