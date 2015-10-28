" vim:foldmethod=marker:foldlevel=0
" Gergely Tamás Kurucz (Temaruk)

" Plug config (plugins) {{{
call plug#begin('~/.vim/plugged')
  Plug 'itchyny/lightline.vim'
  Plug 'fatih/vim-go', {'for': 'go'}
  Plug 'rking/ag.vim'
  Plug 'Shougo/neocomplete.vim'
  Plug 'scrooloose/nerdtree', {'on':  'NERDTreeToggle'}
  Plug 'scrooloose/syntastic'
  Plug 'airblade/vim-gitgutter'
  Plug 'bronson/vim-visual-star-search'
  Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
  Plug 'scrooloose/nerdcommenter'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tpope/vim-sensible/'
  Plug 'justinmk/vim-sneak'
  Plug 'Shougo/vimproc.vim'
  Plug 'Shougo/unite.vim'
  Plug 'Shougo/neomru.vim'
  Plug 'ervandew/supertab'
  Plug 'unblevable/quick-scope'
  Plug 'mxw/vim-jsx'
  Plug 'pangloss/vim-javascript'
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  Plug 'Raimondi/delimitMate'
  Plug 'ihacklog/HiCursorWords'
  Plug 'ap/vim-css-color'
  Plug 'chriskempson/base16-vim'
  Plug 'wakatime/vim-wakatime'
  Plug 'Coornail/vim-go-conceal', {'for': 'go'}
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'jaxbot/syntastic-react'
  Plug 'rhysd/committia.vim'
  Plug 'terryma/vim-expand-region'
  Plug 'vim-scripts/Indent-Highlight'
  Plug 'romainl/vim-qf'
  Plug 'kshenoy/vim-signature'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'chase/vim-ansible-yaml'
  Plug 'ciaranm/securemodelines'
call plug#end()
" }}}

" Colors {{{
colorscheme base16-solarized
set background=dark

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
" }}}

" Spaces & Tabs {{{
set tabstop=2
set shiftwidth=2
set expandtab
" }}}

" UI Config {{{
set nu
set cursorline
set lazyredraw
set mouse=a
set nocompatible
set showfulltag
set smartcase
set spell
set tf
set clipboard=unnamed
" }}}

" Searching {{{
set hlsearch

" }}}

" Shortcuts {{{
" + opens up the tag definition - closes it
map + :pta <C-R><C-W><CR>
map - :pc<CR>

vmap " :s/\%V/"/<CR><ESC>:s/\%#/"/<CR>i
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

imap <C-BS> <C-W>

" }}}

" Leader shortcuts {{{
let mapleader=" ""{{{"}}}

nmap <Leader>s :Unite -buffer-name=grep grep:.::<C-r><C-w><CR>

map <Leader>t :set list!<CR>

" Use Unite to navigate between buffers
"nnoremap <space>b :Unite -quick-match buffer<cr>
nnoremap <silent> <Leader>b :<C-u>Unite -quick-match buffer bookmark<CR>
nnoremap <Leader>/ :Unite grep:.<cr>

nnoremap <Leader>. :CtrlPTag<cr>
" }}}

" Backups {{{
set nobackup
set backupdir=/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=/tmp

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif
" }}}

" Statusline {{{
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [%p%%]\ [LEN=%L]\ [POS=%l,%v]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }}}

" Lightline {{{
let g:lightline = {
  \ 'colorscheme': 'solarized_dark',
  \ }
" }}}

" Autogroups {{{
augroup file_read_write
  au!
  " Jump to the last known line
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  "remove whitespaces from the end of all lines at saving
  au BufWritePre * :%s/\s\+$//e
augroup END
" }}}

" Autocomplete {{{
augroup filetypes_completion
  au!
  au FileType c setlocal omnifunc=ccomplete#Complete
  au FileType css setlocal omnifunc=csscomplete#CompleteCSS
  au FileType html setlocal omnifunc=htmlcomplete#CompleteTags
  au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  au FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
  au FileType python setlocal omnifunc=pythoncomplete#Complete
  au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

let g:AutoComplPop_BehaviorKeywordLength=4

let g:neocomplete#enable_at_startup = 1
" }}}

" Invisible characters {{{
set nolist
exe "set listchars=tab:>-,trail:·,eol:$,nbsp:·"
" }}}

" Unite {{{
" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])
" }}}

" SuperTab {{{
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" }}}

" CtrlP {{{
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
" }}}

" Golang {{{
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

let g:go_fmt_command = "goimports"

augroup filetype_go
  au!
  au FileType go nmap <Leader>t <Plug>(go-test)
  au FileType go nmap <Leader>c <Plug>(go-coverage)
  au FileType go nmap <Leader>ds <Plug>(go-def-split)
  au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
  au FileType go nmap <Leader>s <Plug>(go-implements)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <Leader>e <Plug>(go-rename)
augroup END

" Gotags support
" Requires https://github.com/jstemmer/gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
" }}}

" Syntastic {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:UltiSnipsUsePythonVersion = 3
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_go_checkers = ['gometalinter']
let g:syntastic_go_gometalinter_args = "-D gotype"
" }}}

" Tmux {{{
if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end
" }}}

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:ansible_options = {'ignore_blank_lines': 0}

let g:secure_modelines_allowed_items = ['foldmethod', 'foldlevel']

