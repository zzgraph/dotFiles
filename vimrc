" Pathogen is in a non conventional place, find it and run it

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Automatic syntax highligting and filetype detection

syntax on
filetype plugin indent on

" Loading color scheme
" color happy_hacking
colorscheme gruvbox

set background=dark
" make background transparent in terminal
" set &t_8f="\e[38;2;%ld;%ld;%ldm"
" let &t_8b="\e[48;2;%ld;%ld;%ldm"
" set termguicolors
 hi Normal ctermbg=none

" highlight NonText ctermbg=NONE guibg=NONE
