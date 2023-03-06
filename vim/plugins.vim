" === PLUGIN MANAGER
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
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" - Elixir
Plug 'elixir-editors/vim-elixir'

" Even though ALE supports a mix format fixer, I am keeping this one
" because it prevents saving a file that has syntax errors and opens
" a window with the error stacktrace, making it super easy to catch
" early and fix those super common errors.
Plug 'mhinz/vim-mix-format'

" - Others
Plug 'AndrewRadev/switch.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'Yggdroot/indentLine'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'elzr/vim-json'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'

" This plugin is in principle not needed, because
" text search is performed by ripgrep in combination
" with fzf. I keep this plugin around to leverage the
" command :Ack as a way to display ripgrep's search
" results in a permanent window within vim, for the
" case when the ephimeral window shown by fzf is not
" convinient.
Plug 'mileszs/ack.vim'

Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

call plug#end()

"
" === PLUGINS CONFIGURATION
"
" - Airline
let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2

" - Tmux
" https://github.com/neovim/neovim/issues/2048
if has('nvim')
  nmap <silent> <bs> :<C-u>TmuxNavigateLeft<CR>
endif
" -------

" - NERDTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'blue', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('rb', 'Red', 'none', '#ffa500', '#151515')

map <silent> <Leader>n :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" - Ack
if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case'
endif

cnoreabbrev Ack Ack!

" - Indent Line
let g:indentLine_char = '･'

" - Switch
let g:switch_mapping = '-'

" - Elixir
let g:mix_format_on_save = 1

" - Markdown
let g:markdown_folding = 1

" - ALE
let g:ale_linters = {
\  'bash': ['shellcheck', 'shfmt'],
\  'haml': ['hamllint'],
\  'make': ['checkmake'],
\  'json': ['jq'],
\  'ruby': ['brakeman', 'rubocop'],
\  'elixir': ['mix', 'credo', 'dialyxir'],
\  'docker': ['hadolint'],
\  'terraform': ['checkov', 'terraform', 'terraform-fmt-fixer'],
\  'javascript': ['eslint'],
\  'javascriptreact': ['eslint']
\}

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'bash': ['shfmt'],
\  'json': ['jq'],
\  'ruby': ['rubocop'],
\  'javascript': ['eslint'],
\  'javascriptreact': ['eslint']
\}

let g:ale_fix_on_save = 1
