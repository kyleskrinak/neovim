" let g:loaded_ruby_provider = '~/.rbenv/versions/3.2.1/bin/neovim-ruby-host'
let g:python3_host_prog = '/opt/homebrew/bin/python3'
let g:nvim_config_root = stdpath('config')
let g:config_file_list = [ 'plugins.vim',
\ 'display.vim',
\ 'nerdtree.vim',
\ ]

for f in g:config_file_list
    execute 'source ' . g:nvim_config_root . '/' . f
endfor

