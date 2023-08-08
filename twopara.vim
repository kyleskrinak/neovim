" Save this script in your vimrc or init.vim

" Define a function to format paragraph returns
function! FormatParagraphReturns()
    " Save the current cursor position
    let l:save_cursor = getcurpos()

    " Get the current buffer content
    let l:content = getline(1, '$')

    " Get the current line ending format
    let l:line_ending = &fileformat

    " Set the appropriate replacement string based on the current line ending format
    let l:replacement =
        \ (l:line_ending == 'dos') ? "\r\n" :
        \ (l:line_ending == 'mac') ? "\r" :
        \ "\n"

    " Start with an empty string to store the modified content
    let l:modified_content = ''

    " Loop through all lines in the buffer
    for l:line in l:content
        " Append the content line followed by a paragraph return to the modified content
        let l:modified_content .= l:line . l:replacement
        " Check if the line ends with a single return, and add another return
        if l:line !~# '\n$'
            let l:modified_content .= l:replacement
        endif
    endfor

    " Save the modified content to the buffer with the correct line endings
    call setline(1, split(l:modified_content, "\n"))

    " Restore the cursor position
    call setpos('.', l:save_cursor)

    echo "Paragraph returns formatted successfully."
endfunction

" Define a function to reduce multiple returns to two
function! ReduceMultipleReturns()
    " Save the current cursor position
    let l:save_cursor = getcurpos()

    " Run the global command to reduce multiple returns to two
    " Substitute any sequence of two or more consecutive returns with two returns
    silent! execute '%s/\n\{2,}/\r\r/g'

    " Restore the cursor position
    call setpos('.', l:save_cursor)

    echo "Multiple returns reduced to two."
endfunction

" Map a custom keybinding to call the FormatParagraphReturns function
nnoremap <leader>fp :call FormatParagraphReturns()<CR>

" Map a custom keybinding to call the ReduceMultipleReturns function
nnoremap <leader>frm :call ReduceMultipleReturns()<CR>

" Define a function that calls FormatParagraphReturns followed by ReduceMultipleReturns
function! FormatAndReduceParagraphReturns()
    call FormatParagraphReturns()
    call ReduceMultipleReturns()
endfunction

" Map a custom keybinding to call the FormatAndReduceParagraphReturns function
nnoremap <leader>fr :call FormatAndReduceParagraphReturns()<CR>

" Map a custom command :FormatAndReduce to call the FormatAndReduceParagraphReturns function
command! FormatAndReduce call FormatAndReduceParagraphReturns()