" Pathogen is in a non conventional place, find it and run it

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

set nocompatible

" Automatic syntax highligting and filetype detection

syntax on
filetype plugin indent on

" Enabling autoindent

set autoindent

" Search options

set hlsearch
set incsearch

" Backspace every where

set backspace=indent,eol,start

" Enabling line numbers

set number

" Loading color scheme
set background=dark
" set background=light
set termguicolors

" colorscheme zenburn
" colorscheme vorange
" colorscheme solarized8_dark
" colorscheme solarized8_light
" colorscheme solarized8_dark_flat
" colorscheme solarized8_light_flat
" colorscheme solarized8_dark_high
" colorscheme solarized8_light_high
" colorscheme solarized8_dark_low
" colorscheme solarized8_light_low
" colorscheme happy_hacking
colorscheme gruvbox
" colorscheme tender
" colorscheme PaperColor
" colorscheme jellybeans
" colorscheme wombat256mod
" hi Normal guibg=NONE ctermbg=NONE
" hi NonText ctermbg=none
" hi LineNr ctermbg=none

" make background transparent in terminal
" hi clear

" UTF chars to show invisible charachters
set listchars=tab:▸\ ,eol:¬
set list
set ruler
set wildmenu
set smarttab
set laststatus=2

let g:airline_powerline_fonts = 1
