-- Define a function to format paragraph returns
function formatParagraphReturns()
    -- Save the current cursor position
    local saveCursor = vim.fn.getcurpos()

    -- Get the current buffer content
    local content = vim.fn.getline(1, '$')

    -- Start with an empty string to store the modified content
    local modifiedContent = ''

    -- Loop through all lines in the buffer
    for _, line in ipairs(content) do
        -- Append the content line followed by a paragraph return to the modified content
        modifiedContent = modifiedContent .. line .. '\n\n'
    end

    -- Save the modified content to the buffer
    vim.fn.setline(1, vim.fn.split(modifiedContent, '\n'))

    -- Restore the cursor position
    vim.fn.setpos('.', saveCursor)

    print("Paragraph returns formatted successfully.")
end

-- Map a custom keybinding to call the formatParagraphReturns function
vim.api.nvim_set_keymap('n', '<leader>fp', ':lua formatParagraphReturns()<CR>', { noremap = true, silent = true })

-- Define a function to reduce multiple returns to two
function reduceMultipleReturns()
    -- Save the current cursor position
    local saveCursor = vim.fn.getcurpos()

    -- Run the global command to reduce multiple returns to two
    vim.cmd([[
        %s/\n\{2,}/\r\r/g
    ]])

    -- Restore the cursor position
    vim.fn.setpos('.', saveCursor)

    print("Multiple returns reduced to two.")
end

-- Map a custom keybinding to call the reduceMultipleReturns function
vim.api.nvim_set_keymap('n', '<leader>fr', ':lua reduceMultipleReturns()<CR>', { noremap = true, silent = true })