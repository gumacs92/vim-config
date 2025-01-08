local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local config = {}

return require("telescope").register_extension({
    setup = function(ext_config, _)
        config = vim.tbl_deep_extend("force", config, ext_config or {})
    end,
    exports = {
        prosession = function(opts)
            opts = vim.tbl_deep_extend("force", {}, config, opts or {})

            pickers
                .new(opts, {
                    prompt_title = "Sessions",
                    finder = finders.new_dynamic({
                        entry_maker = function(line)
                            local value = vim.fn.substitute(vim.fn.fnamemodify(line, ":t:r"), "%", "/", "g")
                            local path_split = vim.fn.split(value, "/")
                            return {
                                value = value,
                                display = path_split[#path_split],
                                ordinal = value,
                            }
                        end,
                        fn = function(prompt)
                            local flead = ""
                            if prompt ~= "" then
                                flead = "*" .. prompt
                            end
                            return vim.fn.glob(vim.fn.fnamemodify(vim.g.prosession_dir, ":p") .. flead .. "*.vim", 0, 1)
                        end,
                    }),
                    sorter = sorters.get_generic_fuzzy_sorter(),
                    attach_mappings = function(prompt_bufnr, _map)
                        actions.select_default:replace(function()
                            actions.close(prompt_bufnr)
                            local selection = action_state.get_selected_entry()
                            vim.api.nvim_command(":silent! Prosession " .. selection.value)
                        end)
                        return true
                    end,
                })
                :find()
        end,
    },
})
