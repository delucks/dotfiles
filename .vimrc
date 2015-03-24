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
set expandtab

" Theming
syntax on
colorscheme delucks
if !has('gui_running')
	set t_Co=256
endif

"---------
" Keybinds

" Enhancements
nmap j gj
nmap k gk
nnoremap <Space> :
nnoremap } }zz
nnoremap n nzz
nnoremap <F1> <nop>
cmap w!! %!sudo tee > /dev/null %
nnoremap <silent> <Leader>e :Explore<CR>
nmap <silent> <Leader>m :source ~/.vimrc<CR>

" Buffer Manipulation
nnoremap <silent> <Leader>w :bn<CR>
nnoremap <silent> <Leader>c :bd<CR>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <Leader>b :bp<CR>
nmap <Leader><S-h> :winc H<CR>
nmap <Leader><S-j> :winc J<CR>
nmap <Leader><S-k> :winc K<CR>
nmap <Leader><S-l> :winc L<CR>
nmap <Leader>= <C-w><C-=>

"-------
" Macros

" Transform ~/.Xresources style colors into exported variables
let @x = '0xiexport l5~f:df#i="#A"j'

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
" Vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'ap/vim-buftabline'
Plugin 'kien/ctrlp.vim'
Plugin 'deris/vim-shot-f'
Plugin 'airblade/vim-gitgutter'
call vundle#end()
filetype plugin indent on 

"--------
" Plugins

" CtrlP options
let g:ctrlp_map = '<Leader>q'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <silent> <Leader>a :CtrlPBuffer<CR>
nnoremap <silent> <Leader>q :CtrlP<CR>
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
	\ --ignore .git
	\ --ignore .svn
	\ --ignore .hg
	\ --ignore .swp
	\ --ignore "**/*.pyc"
	\ -g ""'

" Ranger integration
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>

" Buftabline
let g:buftabline_show=1
let g:buftabline_numbers=0
let g:buftabline_separators=0

" GitGutter
nmap <Leader>g <Plug>GitGutterNextHunk
nmap <Leader>G <Plug>GitGutterPrevHunk

" Misc
let g:pep8_map='<Leader>8'
nnoremap <silent> <Leader>h :!markdown_py2 % > /tmp/html && chromium /tmp/html
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
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
	\ setlocal expandtab |
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
autocmd BufRead /home/jamie/notes/*
	\ set nowrap
