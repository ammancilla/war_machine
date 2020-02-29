" --- CONFIGURATION
"
"  Most were taken from Neovim defaults.
"  https://neovim.io/doc/user/vim_diff.html#nvim-defaults

filetype plugin on

set autoread
set background=dark
set complete-=i
set encoding=utf-8
set expandtab
set incsearch
set langnoremap
set nocompatible
set showcmd
set smarttab
set t_Co=256
"
" - Dracula theme
colorscheme dracula

" - Enable syntax highlight
syntax on

" - Backspace works like in most programs
set backspace=indent,eol,start

" - Yankings go to clipboard
set clipboard=unnamed

" - Highlight search matches
set hlsearch

" - Searches are case insentive
set ignorecase

" - Always show statusline
set laststatus=2

" - Mouse support in all modes
set mouse=a

" - Show lines number
set number

" - Escape works immediately
set ttimeoutlen=1000

" - https://github.com/guard/listen/issues/420
set backupcopy=yes
