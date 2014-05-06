if has("gui_running")
	set guifont=Inconsolata\ 14
  set background=dark
endif

set encoding=utf-8
set fileencoding=utf-8

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set number
filetype plugin on
filetype plugin indent on

set list                                                                                                                      
exe "set listchars=tab:>-,trail:\xb7,eol:$,nbsp:\xb7"                                                                         
map <C-TAB> :set invlist<CR>                                                                                                  
set invlist     

"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
"set laststatus=2 

au BufRead,BufNewFile *.go set syntax=go
au BufRead,BufNewFile *.install set syntax=php
au BufRead,BufNewFile *.module set syntax=php
au BufRead,BufNewFile *.test set syntax=php

syntax on
syntax enable
colorscheme solarized

" html5
" HTML 5 tags
syn keyword htmlTagName contained article aside audio bb canvas command datagrid
syn keyword htmlTagName contained datalist details dialog embed figure footer
syn keyword htmlTagName contained header hgroup keygen mark meter nav output
syn keyword htmlTagName contained progress time ruby rt rp section time video
syn keyword htmlTagName contained source figcaption

" HTML 5 arguments
syn keyword htmlArg contained autofocus autocomplete placeholder min max step
syn keyword htmlArg contained contenteditable contextmenu draggable hidden item
syn keyword htmlArg contained itemprop list sandbox subject spellcheck
syn keyword htmlArg contained novalidate seamless pattern formtarget manifest
syn keyword htmlArg contained formaction formenctype formmethod formnovalidate
syn keyword htmlArg contained sizes scoped async reversed sandbox srcdoc
syn keyword htmlArg contained hidden role
syn match   htmlArg "\<\(aria-[\-a-zA-Z0-9_]\+\)=" contained
" this doesn't work because default syntax file alredy define a 'data' attribute
syn match   htmlArg "\<\(data-[\-a-zA-Z0-9_]\+\)=" contained
