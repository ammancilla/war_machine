" === KEY MAPPINGS
"
" - Disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" - Space clears last search highlight
nnoremap <silent> <Space> :noh<CR>

" \f to: Search files with fzf
nnoremap <Bslash>f :Files<CR>

" \b to: Search open buffers with fzf
nnoremap <Bslash>b :Buffers<CR>

" \s to: Search text fzf
nnoremap <Bslash>s :Rg<CR>

" Shift + b to: Change to previous open buffer
nnoremap <S-b> :b#<CR>

" Shift + f to: Copy the current buffer's path
nnoremap <S-f> :let @+ = expand('%')<CR>
