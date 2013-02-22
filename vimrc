syntax on
"Other good colorschemes: zmrok, desert, ElegantBritWhite
colorscheme desert
set nocompatible
set autoindent
set ruler
set history=100
set showcmd
set showmode
set incsearch
set hlsearch
set filetype
" Custom kep mappings
nmap j gj
nmap k gk
nmap ; :
" Compilation / Runner Commands
autocmd FileType cpp map <F9> :!g++ -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType c map <F9> :!gcc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
"map <F10> :VimuxPromptCommand<CR>
" Tab Width and Commenting
set shiftwidth=2
set tabstop=2
autocmd FileType cpp 
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2 |
  \ map <C-c> :call CommentLineToEnd ('// ')<CR>
autocmd FileType python
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
  \ map <C-c> :call CommentLineToEnd ('# ')<CR>
autocmd FileType sh 
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2 |
  \ map <C-c> :call CommentLineToEnd ('# ')<CR>
autocmd FileType java
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
  \ map <C-c> :call CommentLineToEnd ('// ')<CR>
