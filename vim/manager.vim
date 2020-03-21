" --- PLUGIN MANAGER
" https://github.com/junegunn/vim-plug
"
" Looking for awesome plugins?
" http://vimawesome.com/

" Auto install plugins the first time
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $HOME/.vimrc
endif

call plug#begin()

" - Colorscheme
Plug 'dracula/vim', { 'as': 'dracula' }

" - Statusbar
Plug 'vim-airline/vim-airline'

" - Tmux
Plug 'christoomey/vim-tmux-navigator'

" - Nerdtree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'

" - Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" - Ruby (& Rails)
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'

" - Markdown
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" - Others
Plug 'AndrewRadev/switch.vim'
Plug 'Yggdroot/indentLine'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elzr/vim-json'
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

call plug#end()
