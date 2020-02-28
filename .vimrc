set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin on
set number

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif


call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
 Plug 'frazrepo/vim-rainbow'
 Plug 'tpope/vim-fugitive'

" Plug 'itchyny/lightline.vim'

 "let g:lightline = {
"\ 'colorscheme': 'wombat',
"\ }

 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'

 Plug 'scrooloose/nerdcommenter'

 Plug 'sickill/vim-monokai'

 Plug 'junegunn/fzf', { 'do': './install --bin' }
 Plug 'junegunn/fzf.vim'

 Plug 'mileszs/ack.vim'

 Plug 'airblade/vim-gitgutter'

 Plug 'yuttie/comfortable-motion.vim'

 Plug 'vim-scripts/taglist.vim'

 Plug 'nathanaelkane/vim-indent-guides'

 Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang' }

 Plug 'easymotion/vim-easymotion'

call plug#end()
let &t_ut=''

set laststatus=2
syntax enable
colorscheme monokai

set mouse=a

noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


" Tab switching key binds
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>
