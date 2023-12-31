" nvim sets
let mapleader = "<C>"
set shiftwidth=4
set relativenumber
vnoremap <leader>c "+y
vnoremap <leader>v "+p

" Window Navigation with Alt
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" vim-plug setup
call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
call plug#end()

" NERDTree setup
nnoremap <C-n> :call CustomNERDTreeToggle()<CR>
nnoremap <C-r> :call  <CR> 

function! CustomNERDTreeToggle()
    if bufname('%')=~'^NERD_tree'
	exe 'NERDTreeToggle'
    else
	exe 'NERDTreeFocus'
    endif
endfunction

