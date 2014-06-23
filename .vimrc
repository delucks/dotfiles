" delucks' ~/.vimrc

set nocompatible
syntax on
" Other good colorschemes: zmrok, desert, ElegantBritWhite, jellybeans, delek, deepblue, zellner, eclipse, gentooish, elflord, pablo
"colorscheme pyte
set number
"set relativenumber
set ic
"set cursorcolumn
set autoindent
set noruler
set history=100
set noshowcmd
set noshowmode
set incsearch
set hlsearch
set lazyredraw
"set filetype
set autowrite
set splitbelow
set splitright
set ft=zsh ts=4 sw=4
set shortmess=a
"set completefunc
set clipboard^=unnamedplus

if !has('gui_running')
	set t_Co=256
endif

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'arecarn/crunch'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'itchyny/lightline.vim'
call vundle#end()
filetype plugin indent on

" Lightline
set laststatus=2
set noshowmode

" Tab Width
set shiftwidth=2
set tabstop=2

" Custom kep mappings
nmap j gj
nmap k gk
nnoremap <Space> :
cmap w!! %!sudo tee > /dev/null %
nmap <F6> :r!xclip -o <CR>
vmap <F6> :!xclip -f -sel clip<CR>

" Buffer Manipulation
nmap <C-h> <C-w><C-h>
nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-l> <C-w><C-l>
nmap <C-=> <C-w><C-=>

" Compilation / Auto Commands
autocmd FileType cpp map <F9> :!g++ -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType c map <F9> :!gcc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>

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
