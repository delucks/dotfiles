set nocompatible
"execute pathogen#infect()
syntax on
"Other good colorschemes: zmrok, desert, ElegantBritWhite, jellybeans, delek, deepblue, zellner, eclipse, gentooish, elflord
colorscheme herald
set number
"set relativenumber
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
set splitbelow
set splitright
set ft=zsh ts=4 sw=4
set shortmess=a

set completefunc

" Custom kep mappings
nmap j gj
nmap k gk
"map ; :
" nmap <C-h> :b#<CR>
" Buffer Manipulation
nmap <C-h> <C-w><C-h>
nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-l> <C-w><C-l>
nmap <C-=> <C-w><C-=>

nnoremap <Space> :

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
  \ map <C-c> :call CommentLineToEnd ('// ')<CR> |
	\ map <F9> :!javac "%:p" <CR>
autocmd BufRead *i3*
	\ map <C-c> :call CommentLineToEnd ('#')<CR>
autocmd BufRead /home/jamie/.Xresources
	\ map <C-c> :call CommentLineToEnd ('!')<CR> |
	\ map <F9> :!xrdb -merge ~/.Xresources <CR>

augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END
