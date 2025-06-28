-- Unified Lua function to format paragraph returns, remove duplicates, and ensure max two blank lines
local M = {}

function M.format_and_reduce_paragraphs()
    -- Save current cursor position
    local save_cursor = vim.fn.getcurpos()

    -- Get all buffer lines
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    -- Process lines: insert blank after each line, dedupe non-blanks, allow up to two blanks
    local result = {}
    local blank_count = 0
    local last_non_blank = nil

    for _, line in ipairs(lines) do
        if line == "" then
            blank_count = blank_count + 1
            if blank_count <= 2 then
                table.insert(result, "")
            end
        else
            blank_count = 0
            if line ~= last_non_blank then
                table.insert(result, line)
                -- ensure at least one blank after each paragraph
                table.insert(result, "")
                blank_count = 1
                last_non_blank = line
            end
        end
    end

    -- Collapse any runs of 3 or more blank lines to exactly two
    local text = table.concat(result, "\n")
    text = text:gsub("\n\n\n+", "\n\n")
    local final_lines = vim.split(text, "\n", true)

    -- Write the processed lines back to the buffer
    vim.api.nvim_buf_set_lines(0, 0, -1, false, final_lines)

    -- Restore cursor position
    vim.fn.setpos('.', save_cursor)

    print("Formatted, deduplicated, and cleaned blank lines successfully.")
end

-- Map <leader>fr to the combined function
vim.keymap.set('n', '<leader>fr', M.format_and_reduce_paragraphs, { noremap = true, silent = true })

return M