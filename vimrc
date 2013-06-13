execute pathogen#infect()
syntax on
"Other good colorschemes: zmrok, desert, ElegantBritWhite, jellybeans
colorscheme desert
"set relativenumber
set number
set nocompatible
set ic
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
set ft=zsh ts=4 sw=4

" Custom kep mappings
nmap j gj
nmap k gk
nmap ; :
nmap <C-h> :b#<CR>
nmap <F8> :TagbarToggle<CR>
cmap w!! %!sudo tee > /dev/null %
nmap <F6> :r!xclip -o <CR>
vmap <F6> :!xclip -f -sel clip<CR>
" Compilation / Runner Commands
autocmd FileType cpp map <F9> :!g++ -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType c map <F9> :!gcc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
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
autocmd FileType html
	\ map <F10> :!luakit %<CR>
autocmd FileType java
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
  \ map <C-c> :call CommentLineToEnd ('// ')<CR>
autocmd BufRead *i3*
	\ map <C-c> :call CommentLineToEnd ('#')<CR>

augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END
