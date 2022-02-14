set backspace=start,eol,indent
set encoding=utf-8
set fileformat=unix
set laststatus=2
set listchars=tab:>-,trail:-,eol:\ ,extends:»,precedes:«,nbsp:%
set ttimeoutlen=50
set updatetime=100
set autoindent
set autoread
set list
set nobackup
set noundofile
set number
set relativenumber
set nowrap
set nohlsearch
set smartcase

augroup on_any_file
  autocmd!
  autocmd BufRead,BufNewFile * set fileformat=unix
  autocmd BufRead,BufNewFile * set encoding=utf-8
  autocmd BufRead,BufNewFile * set textwidth=120
  autocmd BUfRead,BufNewFile * set shiftwidth=4
  autocmd BufRead,BufNewFile * set noautowrite
  autocmd BufRead,BufNewFIle * set expandtab
  autocmd BufRead,BufNewFIle * set shiftwidth=4
  autocmd BufRead,BufNewFIle * set tabstop=4
augroup END

augroup spacemacs
  autocmd BufRead,BufNewFile .spacemacs set filetype=lisp
augroup END

augroup on_latex
  autocmd!
  autocmd BufRead,BufNewFile *.tex set textwidth=120
augroup END

augroup on_makefile
  autocmd!
  autocmd BufRead,BufNewFile Makefile set textwidth=79
  autocmd BufRead,BufNewFile Makefile set noexpandtab
augroup END

augroup on_scala
  autocmd!
  autocmd BufRead,BufNewFile *.scala set textwidth=120
  autocmd BufRead,BufNewFile *.scala set shiftwidth=2
augroup END

let g:mapleader = ' '
let g:maplocalleader = '\'

nmap <C-j> <C-m>
nmap <A-f> <Plug>(easymotion-overwin-f2)
noremap <C-n> gt
noremap <C-p> gT
nnoremap <C-k> c$
nnoremap <C-x><C-s> :w<CR>
nnoremap <ESC> :w<CR>

noremap! <C-a> <Home>
noremap! <C-b> <Left>
noremap! <C-e> <End>
noremap! <C-d> <Del>
noremap! <C-f> <Right>
noremap! <A-f> <C-Right>
noremap! <A-b> <C-Left>

call plug#begin('~/.local/share/nvim/plugged')
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jam1garner/vim-code-monokai'
call plug#end()

"set runtimepath^=~/.local/share/dein.vim
"if dein#load_state('~/.local/share/dein')
"  call dein#begin('~/.local/share/dein')
"  call dein#add('~/.local/share/dein.vim')
"  call dein#add('Lokaltog/vim-easymotion')
"  call dein#add('kana/vim-smartinput')
"  call dein#add('Shougo/deoplete.nvim')
"  call dein#add('scrooloose/nerdtree')
"  call dein#add('vim-airline/vim-airline')
"  call dein#add('vim-airline/vim-airline-themes')
"  call dein#add('tpope/vim-surround')
"  call dein#end()
"  call dein#save_state()
"endif

let g:deoplete#enable_at_startup = 1

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0

filetype plugin indent on
syntax enable

colorscheme codedark
set guifont=Cica:h12

