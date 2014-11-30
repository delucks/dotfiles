"""
" delucks' ~/.vimrc
"""

set nocompatible
syntax on
" Other good colorschemes: zmrok, desert, ElegantBritWhite, jellybeans, delek, deepblue, zellner, eclipse, gentooish, elflord, pablo
colorscheme vc
set number
"set relativenumber
set ic
"set cursorcolumn
" set foldmethod=syntax
set autoindent
set ruler
set history=100
set smartcase
set showmode
set directory=~/.vim/backup
set incsearch
set hlsearch
set lazyredraw
"set filetype
set autowrite
set splitbelow
set splitright
set shortmess=a
set backspace=indent,eol,start
set suffixes=.bak,~,.swp,.o,.out,.jpg,.png,.gif
"set completefunc
set clipboard^=unnamedplus
set linebreak
let g:netrw_liststyle=3
let @x = '0xiexport l5~f:df#i="#A"j'

set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,eol:→

if !has('gui_running')
	set t_Co=256
endif

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'ap/vim-buftabline'
Plugin 'kien/ctrlp.vim'
Plugin 'duythinht/vim-coffee'
"Plugin 'yakiang/excel.vim'
"Plugin 'itchyny/lightline.vim'
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
nnoremap } }zz
nnoremap n nzz
nnoremap <F1> <nop>
nnoremap <silent> <Leader>q :CtrlPBuffer<CR>

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

" autocmd InsertEnter * !echo 1 > /sys/class/leds/asus::kbd_backlight/brightness &
" autocmd InsertLeave * !echo 0 > /sys/class/leds/asus::kbd_backlight/brightness &

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

function! RangeChooser()
    let temp = tempname()
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>
