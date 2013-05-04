execute pathogen#infect()
syntax on
"Other good colorschemes: zmrok, desert, ElegantBritWhite, jellybeans
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
set splitright
set autowrite
" Custom kep mappings
nmap j gj
nmap k gk
nmap ; :
nmap <C-h> :b#<CR>
nmap <F8> :TagbarToggle<CR>
cmap w!! %!sudo tee > /dev/null %
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
  \ map <C-c> :call CommentLineToEnd ('# ')<CR> |
	\ map <F9> :!python2 "%:p" <CR>
autocmd FileType sh 
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2 |
  \ map <C-c> :call CommentLineToEnd ('# ')<CR> |
	\ map <F9> :!./%
autocmd FileType java
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
  \ map <C-c> :call CommentLineToEnd ('// ')<CR>
