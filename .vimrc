:set encoding=utf-8
let mapleader = " "

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'RRethy/vim-hexokinase'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'

Plug 'jqno/reversal.vim'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'natebosch/vim-lsc'

Plug 'machakann/vim-sandwich'

call plug#end()


" *****************************************
" ** Plugin configuration
" *****************************************

" *** Hexokinase
let g:Hexokinase_ftAutoload = ['css', 'scss', 'html']
let g:Hexokinase_refreshEvents = ['BufWritePost']

" Mappings for vim-commentary
xmap \ <Plug>Commentary
nmap \ <Plug>Commentary
omap \ <Plug>Commentary
nmap \\ <Plug>CommentaryLine
nmap <leader>\ <Plug>Commentary<Plug>Commentary


" *****************************************
" ** Language Server(s) Config
" *****************************************

let g:lsc_server_commands = {
  \ 'go' : {
  \   'name': 'gopls',
  \   'command': '/Users/kramor/Development/Projects/Politie/cockroach/bin/gopls',
  \   },
  \}


" *****************************************
" ** Customized configuration
" *****************************************

syntax on
filetype plugin indent on

set termguicolors
silent! colorscheme reversal

:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

:set tabstop=2
:set softtabstop=0
:set expandtab
:set shiftwidth=2
:set smarttab

:set splitright

" Backspace over indents, eols, line-starts: just like normal editors
set backspace=indent,eol,start

" *****************************************
" ** Prevent stray SHIFT keys from blocking
" ** my flow
" *****************************************

:command WQ wq
:command Wq wq
:command W w
:command Q q

" Toggles to reading mode where cursor is kept mid-screen when scrolling
nnoremap <silent> <leader>ts :exec 'set scrolloff=' . (104-&scrolloff)<CR>

