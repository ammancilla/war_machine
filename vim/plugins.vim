" PLUGINS CONFIGURATION
"
" - Airline
let g:airline_theme = 'dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
" -------

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
" -------

" - Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" -------

" - Ctrl - p
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/node_modules/*,*/platforms/*,*/plugins/*
" -------

" - Indent Line
let g:indentLine_char = '･'
" -------

" - Switch
let g:switch_mapping = '-'
" -------

" - Terraform
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1
" -------

"  - Go
let g:go_version_warning = 0
" -------
