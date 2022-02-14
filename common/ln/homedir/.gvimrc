set winaltkeys=no
set lines=50
set columns=125
set guicursor=a:blinkon0
set cursorline cursorcolumn

if has('win64')
    set background=dark
    colorscheme molokai
    hi Normal guibg=Black
elseif has('unix')
    colorscheme lanox
    hi ColorColumn ctermfg=16 ctermbg=253 cterm=NONE guifg=#000000 guibg=#181818 gui=NONE
endif
hi CursorColumn ctermfg=White ctermbg=Black cterm=None guibg=#080808 gui=None
hi CursorLine ctermfg=White ctermbg=Black cterm=None guibg=#080808 gui=None
