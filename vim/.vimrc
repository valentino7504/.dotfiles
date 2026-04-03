set nocompatible
set backspace=indent,eol,start
set number
set relativenumber

set clipboard=unnamedplus
set ignorecase
set smartcase
set incsearch
set hlsearch

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent

set termguicolors
set background=dark
colorscheme rosepine


set background=dark
colorscheme rosepine

set laststatus=2
set noshowmode

let g:mode_map = {
  \ 'n': 'NORMAL', 'i': 'INSERT', 'v': 'VISUAL', 'V': 'V-LINE',
  \ "\<C-v>": 'V-BLOCK', 'R': 'REPLACE', 's': 'SELECT', 'S': 'S-LINE',
  \ 'c': 'COMMAND', 't': 'TERMINAL'
  \ }


set statusline=
set statusline+=\ %{get(g:mode_map,mode(),'NORMAL')}
set statusline+=\ \|\ 
set statusline+=%f
set statusline+=%m
set statusline+=%r
set statusline+=%=
set statusline+=%y
set statusline+=\ \|\ 
set statusline+=%l:%c
set statusline+=\ \|\ 
set statusline+=%p%%\
