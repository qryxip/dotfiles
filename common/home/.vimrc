set runtimepath+=~/.vim/dein.vim
call dein#begin('~/.cache/dein')
call dein#add('Lokaltog/vim-easymotion')
call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('jreybert/vimagit')
call dein#add('kana/vim-smartinput')
call dein#add('miyakogi/seiya.vim')
call dein#add('osyo-manga/shabadou.vim')
call dein#add('sickill/vim-monokai')
call dein#add('thinca/vim-quickrun')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('vim-syntastic/syntastic')
call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')
"call dein#add('Shougo/deoplete.nvim')
"call dein#add('roxma/nvim-yarp')
"call dein#add('roxma/vim-hug-neovim-rpc')
call dein#end()
if dein#check_install()
    call dein#install()
endif

set ambiwidth=double
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

if !&compatible
    set nocompatible
endif

if exists('&colorcolumn')
    set colorcolumn=+1
endif

if !has('gui_runnig')
    set t_Co=256
    colorscheme monokai
endif

let g:mapleader = ' '
let g:maplocalleader = '\'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_monokai'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_use_migemo = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_camel_case_completion = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#use_vimproc = 1
let g:neocomplete#force_omni_input_patterns = {}
let g:neosnippet#snippets_directory='~/.vim/snippets'
let g:seiya_auto_enable = !has('gui_running')
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [] }

filetype on
filetype plugin on
filetype plugin indent on
syntax on
retab

if has('unix')
    map <C-j> <C-m>
endif

nnoremap <Space> <Nop>
noremap! <C-d> <Del>
nnoremap <C-k> c$
nnoremap <C-x><C-s> :w<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT
nmap <A-f> <Plug>(easymotion-overwin-f2)
nmap <Leader>w <Plug>(easymotion-overwin-w)
map  <Leader>l <Plug>(easymotion-bd-jk)
inoremap <C-l> <C-k>
imap <C-i> <Plug>(neosnippet_expand_or_jump)
smap <C-i> <Plug>(neosnippet_expand_or_jump)
xmap <C-i> <Plug>(neosnippet_expand_target)
smap <expr><C-i> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-i>"

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

autocmd BufRead,BufNewFile .spacemacs set filetype=lisp

augroup on_other_files
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

augroup on_latex
    autocmd!
    autocmd BufRead,BufNewFile *.tex set textwidth=120
augroup END

augroup on_pascal
    autocmd!
    autocmd BufRead,BufNewFile *.pas set shiftwidth=2
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

if has('win64')
    "set runtimepath+=~/.vim/dein.vim
    "call dein#begin('~/.vim/dein')
    "call dein#add('Lokaltog/vim-easymotion')
    "call dein#add('Shougo/neocomplete.vim')
    "call dein#add('Shougo/neosnippet-snippets')
    "call dein#add('Shougo/neosnippet.vim')
    "call dein#add('Shougo/vimproc.vim', {'build': 'mingw32-make'})
    "call dein#add('iamcco/markdown-preview.vim')
    "call dein#add('vim-airline/vim-airline')
    "call dein#add('vim-airline/vim-airline-themes')
    "call dein#add('kana/vim-smartinput')
    "call dein#add('scrooloose/nerdtree')
    "call dein#add('lervag/vimtex')
    "call dein#end()
    "let g:netrw_nogx = 1
    "nmap gx <Plug>(openbrowser-smart-search)
    "vmap gx <Plug>(openbrowser-smart-search)
    "let g:vimtex_latexmk_continuous = 1
    "let g:vimtex_latexmk_background = 1
    "let g:vimtex_latexmk_options = '-pdfdvi'
    "let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
    "let g:mkdp_path_to_chrome = 'chrome'
    "let g:neocomplete#enable_at_startup = 1
    "let g:neocomplete#enable_smart_case = 1
    "let g:neocomplete#enable_underbar_completion = 1
    "let g:neocomplete#enable_camel_case_completion = 1
    "let g:neocomplete#auto_completion_start_length = 1
    "let g:neocomplete#use_vimproc = 1
    "let g:neocomplete#force_omni_input_patterns = {}
    "let g:neocomplete#force_omni_input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*::'
    "let g:neosnippet#snippets_directory='Z:/repos/dotfiles/vim/neosnippets'
    "call smartinput#map_to_trigger('i', '$', '$', '$')
    "call smartinput#define_rule({
    "            \        'mode': 'i',
    "            \        'at': '\%#',
    "            \        'char': '$',
    "            \        'input': '$$<Left>',
    "            \        'filetype': ['tex'],
    "            \        'syntax': []
    "            \    })
    "call smartinput#define_rule({
    "            \        'mode': 'i',
    "            \        'at': '\%#\_s*\$',
    "            \        'char': '<Right>',
    "            \        'input': 'AAAAAAAAA!!!!!!',
    "            \        'filetype': ['tex'],
    "            \        'syntax': []
    "            \    })
    "            "        'input': '<C-r>=smartinput#_leave_block(''$'')<CR><Right>',
    "call smartinput#define_rule({
    "            \        'mode': 'i',
    "            \        'at': '\$\%#\$',
    "            \        'char': '<BS>',
    "            \        'input': '<BS><Del>',
    "            \        'filetype': ['tex'],
    "            \        'syntax': []
    "            \    })
    "call smartinput#define_rule({
    "            \        'mode': 'i',
    "            \        'at': '$$\%#',
    "            \        'char': '<BS>',
    "            \        'input': '<BS><BS>',
    "            \        'filetype': ['tex'],
    "            \        'syntax': []
    "            \    })
    "call smartinput#define_rule({
    "            \        'mode': 'i',
    "            \        'at': '\\\%#',
    "            \        'char': '$',
    "            \        'input': '$',
    "            \        'filetype': ['tex'],
    "            \        'syntax': []
    "            \    })
    "call smartinput#define_rule({
    "            \        'mode': 'i',
    "            \        'at': '\$\%#\$',
    "            \        'char': '<CR>',
    "            \        'input': '<CR><CR><Up><Esc>"_S',
    "            \        'filetype': ['tex'],
    "            \        'syntax': []
    "            \    })
elseif has('unix')
    "let g:jedi#completions_command = '<C-Space>'
    "let g:jedi#rename_command = '<LocalLeader>r'
    "let g:jedi#force_py_version = 3
    "let g:clang_auto = 1
    "let g:clang_check_syntax_auto = 1
    "let g:clang_c_options = '-std=c11 -Wall'
    "let g:clang_cpp_options = '-std=c++14 -Wall'
    "let g:neocomplete#enable_at_startup = 1
    "let g:neocomplete#enable_smart_case = 1
    "let g:neocomplete#enable_underbar_completion = 1
    "let g:neocomplete#enable_camel_case_completion = 1
    "let g:neocomplete#force_omni_input_patterns = {}
    "let g:neocomplete#force_omni_input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*::'
    "let g:neosnippet#snippets_directory='~/neosnippets'
    "let g:merlin_highlighting = 1
    "let g:seiya_auto_enable = !has('gui_running')
    "let g:syntastic_python_checkers = ['flake8']
    "let g:syntastic_mode_map = {
    "            \ 'mode': 'passive',
    "            \ 'active_filetypes': [] }
    "if has('gui')
    "    let g:lightline = {
    "                \ 'colorscheme': 'wombat',
    "                \ 'component': {
    "                \   'readonly': '%{&readonly?"x":""}',
    "                \ },
    "                \ 'separator': { 'left': '', 'right': '' },
    "                \ 'subseparator': { 'left': '>', 'right': '<' }
    "                \ }
    "else
    "    let g:lightline = {
    "                \ 'colorscheme': 'wombat',
    "                \ 'component': {
    "                \   'readonly': '%{&readonly?"":""}',
    "                \ },
    "                \ 'separator': { 'left': '', 'right': '' },
    "                \ 'subseparator': { 'left': '>', 'right': '<' }
    "                \ }
    "endif
    "let g:vimtex_latexmk_continuous = 1
    "let g:vimtex_latexmk_background = 1
    "let g:vimtex_latexmk_options = '-pdfdvi'
    "let g:vimtex_view_general_viewer = 'evince'
endif

augroup on_gui
    autocmd!
    autocmd GUIEnter * set guioptions-=T
    autocmd GUIEnter * set guioptions-=r
    autocmd GUIEnter * set guioptions-=R
    autocmd GUIEnter * set guioptions-=l
    autocmd GUIEnter * set guioptions-=L
    autocmd GUIEnter * set guioptions-=b
    autocmd GUIEnter * set guioptions-=m
    if has('win64')
        set runtimepath+=~/.vim
        autocmd GUIEnter    * set guifont=ゆたぽん（コーディング）BoldSl:h9:cANSI
        autocmd GUIEnter    * set transparency=245
        autocmd FocusGained * set transparency=245
        autocmd FocusLost   * set transparency=230
    elseif has('unix')
        autocmd GUIEnter * set guifont=ゆたぽん（コーディング）BoldSl\ 9
    endif
augroup END
