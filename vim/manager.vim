" --- PLUGIN MANAGER
" https://github.com/junegunn/vim-plug
"
" Looking for awesome plugins?
" http://vimawesome.com/

" Automatically install VimPlug
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

" - Custom textobjects
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

" - Tmux
Plug 'christoomey/vim-tmux-navigator'

" - Nerdtree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'

" - Git
Plug 'airblade/vim-gitgutter'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" - Ruby
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'

" - Markdown
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" - Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'

" - Terraform
Plug 'hashivim/vim-terraform'

" - Others
Plug 'AndrewRadev/switch.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'Yggdroot/indentLine'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'elzr/vim-json'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

call plug#end()
