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
set shortmess+=aI
set backspace=indent,eol,start
set suffixes=.bak,~,.swp,.o,.out,.jpg,.png,.gif
set linebreak
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,eol:→
set noswapfile
set virtualedit=block
set wildmode=longest,list
let g:netrw_liststyle=3
let g:netrw_browser_viewer= "chromium"

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
nnoremap n nzz
nnoremap <F1> <nop>
nnoremap Q <nop>
cmap w!! %!sudo tee > /dev/null %
nnoremap <silent> <Leader>e :Explore<CR>
nmap <silent> <Leader>m :source ~/.vimrc<CR>

" Buffer Manipulation
nnoremap <silent> <Leader>w :bn<CR>
nnoremap <silent> <Leader>c :bd<CR>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <Leader>b :bp<CR>

" Window movement
nmap <Leader>h <C-w><C-h>
nmap <Leader>j <C-w><C-j>
nmap <Leader>k <C-w><C-k>
nmap <Leader>l <C-w><C-l>
nmap <Leader><S-h> :winc H<CR>
nmap <Leader><S-j> :winc J<CR>
nmap <Leader><S-k> :winc K<CR>
nmap <Leader><S-l> :winc L<CR>
nmap <Leader>= <C-w><C-=>

"-------
" Macros

" Transform ~/.Xresources style colors into exported variables
let @x = '0xiexport l5~f:df#i="#A"j'
" Transform hlwm keybinds into i3 keybinds
let @h = '0c2wbindsymwf wcwexec'

"----------
" Functions

function! RangerChooser()
    let temp = tempname()
    if has('nvim') 
      exec 'terminal ranger --choosefiles=' . shellescape(temp)
    else
      exec '!ranger --choosefiles=' . shellescape(temp)
    endif
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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'deris/vim-shot-f'
Plugin 'airblade/vim-gitgutter'
Plugin 'amoffat/snake'
Plugin 'junegunn/limelight.vim'
call vundle#end()
filetype plugin indent on 

"--------
" Plugins

" CtrlP options
let g:ctrlp_map = '<Leader>q'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <silent> <Leader>a :CtrlPBuffer<CR>
nnoremap <silent> <Leader>q :CtrlP<CR>
" Only set it to be ag if it's installed (whew)
if executable("ag")
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .swp
    \ --ignore "**/*.pyc"
    \ -g ""'
endif

" limelight.vim

nmap <silent> gl :Limelight!!<CR>
xmap gl <Plug>(Limelight)
let g:limelight_conceal_ctermfg = 8
let g:limelight_paragraph_span = 2

" Ranger integration
command! -bar RangerChoose :call RangerChooser()
nnoremap <leader>r :<C-U>RangerChoose<CR>

" Buftabline
let g:buftabline_show=1
let g:buftabline_numbers=0
let g:buftabline_separators=0

" GitGutter
nmap <Leader>g <Plug>GitGutterNextHunk
nmap <Leader>G <Plug>GitGutterPrevHunk

" Misc
let g:pep8_map='<Leader>8'
"nnoremap <silent> <Leader>h :!markdown_py2 % > /tmp/html && chromium /tmp/html
nmap <F6> :r!xclip -o <CR>
vmap <F6> :!xclip -f -sel clip<CR>
nnoremap <leader>v :e ~/.vimrc<CR>
nnoremap J mzJ`z

" nvim specific commands
if has('nvim') 
  function! SplitTerm(direction)
    if (a:direction == "v")
      :vsp
    else
      :sp
    endif
    :term
  endfunction
  tnoremap <Leader>e <C-\><C-n>
  tnoremap <Leader>h <C-\><C-n><C-w>h
  tnoremap <Leader>k <C-\><C-n><C-w>k
  tnoremap <Leader>j <C-\><C-n><C-w>j
  tnoremap <Leader>l <C-\><C-n><C-w>l
endif

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
  \ nnoremap <Leader><Space> :s/"/'/g<CR> |
  \ map K :term pydoc2 %s<CR>
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
	\ set wrap
autocmd BufRead /home/jamie/.ssh/config
  \ set foldmethod=indent
