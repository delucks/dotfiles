"---------
" ~/.vimrc

"---------
" Settings

set nocompatible

" ui
set number
set ruler
set showmode
set lazyredraw
set showcmd
" remove hit-enter prompts for intro
set shortmess+=I
" for :set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,eol:→
" theming
syntax on
colorscheme delucks
if !has('gui_running')
	set t_Co=256
endif

" searching
set ignorecase
set smartcase
set incsearch
set hlsearch

" editing
set autoindent
set foldmethod=indent
set history=100
set splitright
" text wrapping
set wrap
set sidescroll=1
" write swap file after 10 characters
set updatecount=10
" control what we can backspace over in insert
set backspace=indent,eol,start
" let us edit text that's not there in block mode
set virtualedit=block
" tab width
set shiftwidth=2
set tabstop=2
set expandtab

" misc
let g:sh_no_error = 1
let g:markdown_fenced_languages = ['python', 'java', 'sh', 'vim']
" ignore the following files (or give low preference)
set suffixes=.bak,~,.swp,.o,.out,.jpg,.png,.gif,.class
let g:netrw_liststyle=2
if executable("rg")
  set grepprg=ag
elseif executable("ack")
  set grepprg=ack
endif

"--------
" Plugins

call plug#begin('~/.vim/plugins')
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'ap/vim-buftabline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'deris/vim-shot-f'
Plug 'mhinz/vim-signify'
Plug 'junegunn/limelight.vim'
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'stephpy/vim-yaml'
Plug 'tpope/vim-fugitive'
Plug 'benmills/vimux'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
if executable("elixir")
  Plug 'elixir-lang/vim-elixir'
endif
call plug#end()

"---------------
" Plugin Options

" vimux
" Tmux-Command
nmap <Leader>tc :VimuxPromptCommand<CR>
" Tmux-Last
nmap <Leader>tl :VimuxRunLastCommand<CR>
" Tmux-eXit
nmap <Leader>tx :VimuxInterruptRunner<CR>
" Tmux-Scroll
nmap <Leader>ts :VimuxInspectRunner<CR>
" Tmux-Zoom
nmap <Leader>tz :VimuxZoomRunner<CR>

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

"---------
" Keybinds

" Enhancements
nmap j gj
nmap k gk
nnoremap <Space> :
nnoremap n nzz
nnoremap J mzJ`z
cmap w!! %!sudo tee > /dev/null %
" launch left-side netrw browser
nnoremap <silent> <Leader>e :Lexplore<CR>
" improve my search and replace workflow
nmap S :%s//g<LEFT><LEFT>
nmap <expr>  M  ':%s/' . @/ . '//g<LEFT><LEFT>'

" get rid of some keys
nnoremap <F1> <nop>
nnoremap Q <nop>

" Buffer Manipulation
nnoremap <silent> <Leader>w :bn<CR>
nnoremap <silent> <Leader>c :bd<CR>
nnoremap <silent> <Leader>b :bp<CR>
nnoremap <Tab> :b<space>

" way better than default
nmap <left> :bp<CR>
nmap <right> :bn<CR>
nmap <up> :%foldopen<CR>
nmap <down> :%foldclose<CR>

" Window movement
nmap <C-h> <C-W><C-H>
nmap <C-j> <C-W><C-J>
nmap <C-k> <C-W><C-K>
nmap <C-l> <C-W><C-L>
" Also provide <Leader> shortcuts
nmap <Leader>h <C-W><C-H>
nmap <Leader>j <C-W><C-J>
nmap <Leader>k <C-W><C-K>
nmap <Leader>l <C-W><C-L>
nmap <Leader><S-h> :winc H<CR>
nmap <Leader><S-j> :winc J<CR>
nmap <Leader><S-k> :winc K<CR>
nmap <Leader><S-l> :winc L<CR>
nmap <Leader>= <C-w><C-=>

" Misc
nmap <F6> :r!xclip -o <CR>
vmap <F6> :!xclip -f -sel clip<CR>

"-------
" Macros

" Transform ~/.Xresources style colors into exported variables
let @x = '0xiexport l5~f:df#i="#A"j'
" Transform hlwm keybinds into i3 keybinds
let @h = '0c2wbindsymwf wcwexec'
" Insert a line of all = the same length as the current one
let @e = 'yyp:s/./=/g'

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

" filetype-specific commands
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
  \ setlocal nowrap
autocmd FileType sh 
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2 |
	\ map <F9> :!./%
autocmd FileType go
  \ setlocal nowrap
autocmd FileType java
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
	\ map <Leader>z :!javac "%:p" <CR>
autocmd BufRead *.clj
  \ set filetype=clojure
autocmd FileType vim
  \ map K :execute('vert help ' . expand("<cword>"))<CR><C-w><C-h>
