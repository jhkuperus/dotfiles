:set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'derekwyatt/vim-scala'
Plug 'RRethy/vim-hexokinase'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'

Plug 'jqno/vim-reversal'

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
