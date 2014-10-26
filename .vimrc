"""
" delucks' ~/.vimrc
"""

set nocompatible
syntax on
" Other good colorschemes: zmrok, desert, ElegantBritWhite, jellybeans, delek, deepblue, zellner, eclipse, gentooish, elflord, pablo
"colorscheme gotham
set number
"set relativenumber
set ic
"set cursorcolumn
set autoindent
set noruler
set history=100
set noshowcmd
set showmode
set incsearch
set hlsearch
set lazyredraw
"set filetype
set autowrite
set splitbelow
set splitright
set shortmess=a
"set completefunc
set clipboard^=unnamedplus
let g:netrw_liststyle=3

set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,eol:→

if !has('gui_running')
	set t_Co=256
endif

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'duythinht/vim-coffee'
"Plugin 'yakiang/excel.vim'
"Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vinegar.vim'
call vundle#end()
filetype plugin indent on

" Lightline
"set laststatus=2
set showmode

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
nnoremap <silent> <Leader>r :let [&nu, &rnu] = [&nu+&rnu==0, &nu]<CR>
nnoremap <silent> <Leader>b :bn<CR>
nnoremap <silent> <Leader>w :bp<CR>
nnoremap <silent> <Leader><Up> :sp<CR>
nnoremap <silent> <Leader><Down> :sp<CR>
nnoremap <silent> <Leader><Left> :vsp<CR>
nnoremap <silent> <Leader><Right> :vsp<CR>
nnoremap <silent> <Leader>e :Explore<CR>

" Buffer Manipulation
nmap <Leader>h <C-w><C-h>
nmap <Leader>j <C-w><C-j>
nmap <Leader>k <C-w><C-k>
nmap <Leader>l <C-w><C-l>
nmap <Leader><S-h> :winc H<CR>
nmap <Leader><S-j> :winc J<CR>
nmap <Leader><S-k> :winc K<CR>
nmap <Leader><S-l> :winc L<CR>
nmap <Leader>= <C-w><C-=>

" Compilation / Auto Commands
autocmd FileType cpp map <F9> :!g++ -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType c map <F9> :!gcc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>

autocmd FileType cpp 
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2 |
  \ map <C-c> :call CommentLineToEnd ('// ')<CR>
autocmd FileType python
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2 |
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
