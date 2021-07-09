" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
" call plug#begin('~/AppData/Local/nvim/plugged/')
call plug#begin( stdpath('config') . '/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-surround'
Plug 'lifepillar/vim-solarized8'
Plug 'Chiel92/vim-autoformat'
Plug 'mattn/emmet-vim'
Plug 'timcharper/textile.vim'
Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'evidens/vim-twig'
Plug 'falstro/ghost-text-vim'
Plug 'vim-scripts/diffchar.vim'
Plug 'shime/vim-livedown'
Plug 'vimoutliner/vimoutliner'
Plug 'jlanzarotta/bufexplorer'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()
