"---------
" ~/.vimrc

"---------
" Settings

set nocompatible
set number
set ic
set autoindent
set ruler
set history=100
set smartcase
set showmode
set incsearch
set hlsearch
set lazyredraw
set autowrite
set splitbelow
set splitright
set shortmess=a
set backspace=indent,eol,start
set suffixes=.bak,~,.swp,.o,.out,.jpg,.png,.gif
set linebreak
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,eol:→
let g:netrw_liststyle=3

" Tab Width
set shiftwidth=2
set tabstop=2

" Theming
syntax on
colorscheme noctu
if !has('gui_running')
	set t_Co=256
endif

"-------
" Vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'ap/vim-buftabline'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-dispatch'
call vundle#end()
filetype plugin indent on 

"----------
" Functions

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

"-------
" Macros

" Transform ~/.Xresources style colors into exported variables
let @x = '0xiexport l5~f:df#i="#A"j'

"---------
" Keybinds

" Default enhancements
nmap j gj
nmap k gk
nnoremap <Space> :
nnoremap } }zz
nnoremap n nzz
nnoremap <F1> <nop>

" Buffer Manipulation
nnoremap <silent> <Leader>b :bn<CR>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <Leader>w :bp<CR>
nnoremap <silent> <Leader><Up> :sp<CR>
nnoremap <silent> <Leader><Down> :sp<CR>
nnoremap <silent> <Leader><Left> :vsp<CR>
nnoremap <silent> <Leader><Right> :vsp<CR>
nnoremap <silent> <Leader><h> :!markdown_py2 % > /tmp/html && chromium /tmp/html
nmap <Leader><S-h> :winc H<CR>
nmap <Leader><S-j> :winc J<CR>
nmap <Leader><S-k> :winc K<CR>
nmap <Leader><S-l> :winc L<CR>
nmap <Leader>= <C-w><C-=>

" CtrlP options
let g:ctrlp_map = '<Leader>a'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <silent> <Leader>q :CtrlPBuffer<CR>
nnoremap <silent> <Leader>a :CtrlP<CR>

" Ranger integration
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>

" Misc
nnoremap <silent> <Leader>e :Explore<CR>
cmap w!! %!sudo tee > /dev/null %
nmap <F6> :r!xclip -o <CR>
vmap <F6> :!xclip -f -sel clip<CR>

"-------------
" Autocommands

" Reload ~/.vimrc after saving
autocmd! bufwritepost .vimrc source %
autocmd bufreadpost * normal `"

autocmd FileType c 
	\ map <Leader>z :!gcc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType cpp 
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2 |
  \ map <C-c> :call CommentLineToEnd ('// ')<CR> |
	\ map <Leader>z :!g++ -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
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
autocmd FileType go
  \ map <Leader>h :GoDoc<CR> |
	\ map <Leader>z :GoBuild<CR>
autocmd FileType java
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
  \ map <C-c> :call CommentLineToEnd ('// ')<CR> |
	\ map <Leader>z :!javac "%:p" <CR>
autocmd BufRead *i3*
	\ map <C-c> :call CommentLineToEnd ('#')<CR>
autocmd BufRead /home/jamie/.Xresources
	\ map <C-c> :call CommentLineToEnd ('!')<CR> |
	\ map <F9> :!xrdb -merge ~/.Xresources <CR>
