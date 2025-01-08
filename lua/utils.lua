local M = {}

-- Function to escape Lua patterns
local function escape_pattern(str)
    return str:gsub("[%[%]%%().%*+-?^$]", "%%%0")
end

M.has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.search_in_buffer = function(buffer, search_string)
    -- Escape the search string to avoid pattern matching issues
    local escaped_string = escape_pattern(search_string)

    -- Get all lines in the buffer
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)

    -- Search for the string line by line
    for i, line in ipairs(lines) do
        if line:find(escaped_string) then
            print("Found at line " .. i .. ": " .. line)
            return i
        end
    end
end

M.split = function(text, delimiter)
    local result = {}

    -- If delimiter is empty, just return the whole string in a table
    if delimiter == "" then
        table.insert(result, text)
        return result
    end

    local startPos = 1
    while true do
        -- Find the next occurrence of the delimiter
        local foundPos, endPos = string.find(text, delimiter, startPos, true)

        if not foundPos then
            -- No more delimiters found, so insert the remainder of the string
            table.insert(result, string.sub(text, startPos))
            break
        end

        -- Insert everything up to the delimiter into the result
        table.insert(result, string.sub(text, startPos, foundPos - 1))

        -- Move startPos just after the delimiter
        startPos = endPos + 1
    end

    return result
end

M.inspect_bytes = function(input)
    for i = 1, #input do
        print(i, string.byte(input, i))
    end
end

return M
