

local M = {}

M.setup = function()

-- autocmd FileType * setlocal shiftwidth=4 tabstop=4 expandtab
-- autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 expandtab
-- autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab
-- autocmd FileType json setlocal shiftwidth=2 tabstop=2 expandtab
-- autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 expandtab
-- autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2 expandtab
-- autocmd FileType vue setlocal shiftwidth=2 tabstop=2 expandtab
--
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "setlocal shiftwidth=4 tabstop=4 expandtab"
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typescript",
    command = "setlocal shiftwidth=2 tabstop=2 expandtab"
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "javascript",
    command = "setlocal shiftwidth=2 tabstop=2 expandtab"
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    command = "setlocal shiftwidth=2 tabstop=2 expandtab"
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typescriptreact",
    command = "setlocal shiftwidth=2 tabstop=2 expandtab"
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "javascriptreact",
    command = "setlocal shiftwidth=2 tabstop=2 expandtab"
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "vue",
    command = "setlocal shiftwidth=2 tabstop=2 expandtab"
})


-- au TextYankPost * silent! lua vim.highlight.on_yank()
--
-- " format on save
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePost * lua formatCode() 
-- augroup END
    --
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    command = "silent! lua vim.highlight.on_yank()"
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    -- group = "FormatAutogroup",
    command = "lua formatCode()"
})

vim.api.nvim_create_autocmd("DirChanged", {
    pattern = "*",
    command = "silent! Prosession"
})

vim.api.nvim_create_user_command('Files', function(opts)
  -- Building the options string from Lua
  local fzf_options = '--layout=reverse --info=inline --preview ~/.config/nvim/plugged/fzf.vim/bin/preview.sh\\ {}'
  -- Use vim.fn to call the vim function
  vim.fn['fzf#vim#files'](opts.args, {options = fzf_options}, opts.bang)
end, {nargs = '?', complete = 'dir', bang = true})
vim.cmd([[ runtime macros/sandwich/keymap/surround.vim ]])


-- " set foldmethod=expr
-- " set foldexpr=nvim_treesitter#foldexpr()
-- " autocmd BufReadPost,FileReadPost * normal zR
end

return M
