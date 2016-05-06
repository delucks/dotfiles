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
set updatecount=10
let g:netrw_liststyle=2

" Tab Width
set shiftwidth=2
set tabstop=2
set expandtab

" Theming
syntax on
colorscheme delucks
nmap \cr :color delucks<CR>
if !has('gui_running')
	set t_Co=256
endif
let g:markdown_fenced_languages = ['python', 'java', 'sh', 'vim']
let g:sh_no_error = 1


"--------
" Plugins

call plug#begin('~/.vim/plugins')
Plug 'vim-scripts/ScrollColors'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'ap/vim-buftabline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'deris/vim-shot-f'
Plug 'mhinz/vim-signify'
Plug 'amoffat/snake'
Plug 'junegunn/limelight.vim'
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'stephpy/vim-yaml'
Plug 'tpope/vim-fugitive'
call plug#end()

"---------
" Keybinds

" Enhancements
nmap j gj
nmap k gk
nnoremap <Space> :
nnoremap n nzz
nnoremap <F1> <nop>
nnoremap Q <nop>
inoremap jk <Esc>
cmap w!! %!sudo tee > /dev/null %
" launch left-side netrw browser
nnoremap <silent> <Leader>e :Lexplore<CR>
nmap <silent> <Leader>m :source ~/.vimrc<CR>
" improve my search and replace workflow
nmap S :%s//g<LEFT><LEFT>
nmap <expr>  M  ':%s/' . @/ . '//g<LEFT><LEFT>'

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

"---------------
" Plugin Options

" Signify
let g:signify_vcs_list = [ 'git', 'svn' ]
let g:signify_line_highlight = 0
let g:signify_sign_change = '~'
let g:signify_sign_delete = '-'
nmap <Leader>v <plug>(signify-next-hunk)
nmap <Leader>V <plug>(signify-prev-hunk)

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
    \ --ignore .cpan
    \ --ignore .cache
    \ --ignore .java
    \ --ignore "**/*.pyo"
    \ --ignore "**/*.pyc"
    \ -g ""'
endif

nnoremap <silent> <Leader>B :Gblame<CR>

" ack
if executable("ack")
  set grepprg=ack
endif
nnoremap <Leader>/ :gr 
nnoremap <Leader>. :gr <cword><CR>

" limelight.vim

nmap <silent> gl :Limelight!!<CR>
xmap gl <Plug>(Limelight)
let g:limelight_conceal_ctermfg = 8
let g:limelight_paragraph_span = 0

" Buftabline
let g:buftabline_show=1
let g:buftabline_numbers=0
let g:buftabline_separators=0

" Misc
let g:pep8_map='<Leader>8'
"nnoremap <silent> <Leader>h :!markdown_py2 % > /tmp/html && chromium /tmp/html
nmap <F6> :r!xclip -o <CR>
vmap <F6> :!xclip -f -sel clip<CR>
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
" jump to last used position in every file
autocmd bufreadpost * normal `"

autocmd FileType c 
	\ map <Leader>z :!gcc -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType cpp 
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2 |
	\ map <Leader>z :!g++ -o "%:p:r.out" "%:p" && "%:p:r.out"<CR>
autocmd FileType python
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
	\ setlocal expandtab |
  \ nnoremap <Leader><Space> :s/"/'/g<CR> |
  \ map K pydoc %s<CR>
autocmd FileType sh 
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2 |
	\ map <F9> :!./%
autocmd FileType go
  \ map <Leader>h :GoDoc<CR> |
	\ map <Leader>z :GoBuild<CR>
autocmd FileType java
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
	\ map <Leader>z :!javac "%:p" <CR>
autocmd BufRead ~/dotfiles/shells/.aliasrc
  \ set ft=sh
autocmd BufRead *.clj
  \ set filetype=clojure