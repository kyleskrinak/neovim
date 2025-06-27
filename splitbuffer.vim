function! SplitBufferIntoTabs()
    " Store the current tab position to return to it later
    let initial_tab = tabpagenr()

    " Get all lines from the current buffer
    let all_lines = getline(1, '$')
    
    " Initialize variables
    let chunk = []
    let chunk_length = 0
    let tab_count = 0  " Initialize tab_count for naming the tabs

    " Loop through all lines
    for line in all_lines
        let line_len = strlen(line) + 1  " +1 for the newline character
        let new_length = chunk_length + line_len

        " Check if adding the current line will exceed the character limit
        if new_length > 10240
            " Create a new tab and populate it with the chunk
            tabnew
            call setline(1, chunk)

            " Name the tab
            let tab_count += 1
            let tab_name = printf("%02d", tab_count)
            execute 'file ' . tab_name

            " Reset chunk and chunk_length
            let chunk = [line]
            let chunk_length = line_len
        else
            " Add line to chunk and update chunk_length
            call add(chunk, line)
            let chunk_length = new_length
        endif
    endfor

    " Create a new tab for the remaining chunk if it's not empty
    if len(chunk) > 0
        tabnew
        call setline(1, chunk)

        " Name the remaining tab
        let tab_count += 1
        let tab_name = printf("%02d", tab_count)
        execute 'file ' . tab_name
    endif

    " Return to the initial tab
    execute 'tabn ' . initial_tab
endfunction

" Create a command to invoke the function
command! SplitBufferIntoTabs call SplitBufferIntoTabs()
