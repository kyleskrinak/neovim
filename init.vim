let g:nvim_config_root = stdpath('config')
let g:config_file_list = [ 'ginit.vim',
\ 'display.vim',
\ 'nerdtree.vim',
\ ]

for f in g:config_file_list
    execute 'source ' . g:nvim_config_root . '/' . f
endfor
