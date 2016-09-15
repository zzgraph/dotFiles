set nocompatible
" Pathogen is in a non conventional place, find it and run it

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Loading color scheme
"
set background=dark
" set background=light
if &term =~ "screen*" || &term =~ "tmux*"
     " set termguicolors
     " set t_Co=256
else
     set termguicolors   "using truecolor by default
endif
colorscheme gruvbox
autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE guisp=NONE

" vim-lightline specific configurations
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'component': {
      \   'readonly': '%{&readonly?"RO":""}',
      \ }
      \ }



" Automatic syntax highligting and filetype detection
" 

if has("autocmd")
  " Enable file type detection
  filetype on

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
endif


syntax on
filetype plugin indent on

" Enabling autoindent
"
set autoindent

" Search options
"
set hlsearch
set incsearch

" Backspace every where
"
set backspace=indent,eol,start

" Enabling line numbers
"
set number

" UTF chars to show invisible charachters
"
set listchars=tab:▸\ ,eol:¬

"Some interface tweaks
"
set list
set ruler
set wildmenu
set smarttab
set laststatus=2
set cursorline
set relativenumber
set showcmd
set scrolloff=5


" Tabs
"
set expandtab                  " spaces instead of tabs
set tabstop=4                  " a tab = four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces

" Disable Folding by default
"
set nofoldenable 

