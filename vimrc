set nocompatible
" Pathogen is in a non conventional place, find it and run it

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Loading color scheme
"
set background=dark
" set background=light
set termguicolors   "using truecolor by default

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
" highlight Normal ctermbg=NONE
hi NonText ctermbg=NONE guibg=NONE
" hi LineNr ctermbg=none

" make background transparent in terminal
" hi clear


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

" vim-lightline specific configurations
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
" autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE guisp=NONE
