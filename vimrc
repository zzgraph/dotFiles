" Pathogen is in a non conventional place, find it and run it

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Automatic syntax highligting and filetype detection

syntax on
filetype plugin indent on

" Loading color scheme
" color happy_hacking

colorscheme gruvbox
" colorscheme tender
set background=dark

" make background transparent in terminal

" set termguicolors
highlight Normal ctermbg=none

