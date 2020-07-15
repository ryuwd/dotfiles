set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin on
set number

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
 Plug 'tpope/vim-fugitive'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'

 Plug 'scrooloose/nerdcommenter'

 Plug 'junegunn/fzf', { 'do': './install --bin' }
 Plug 'junegunn/fzf.vim'

 Plug 'mileszs/ack.vim'

 Plug 'airblade/vim-gitgutter'

 Plug 'yuttie/comfortable-motion.vim'

 Plug 'vim-scripts/taglist.vim'

 Plug 'nathanaelkane/vim-indent-guides'

 Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang' }
 
 Plug 'arcticicestudio/nord-vim'

 Plug 'easymotion/vim-easymotion'

call plug#end()

set laststatus=2

colorscheme nord " monokai

if (has("termguicolors"))
  set termguicolors
endif

syntax enable

"if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=""
"endif

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

set backspace=indent,eol,start

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

" Enable spellcheck for emails
autocmd FileType mail set spell


