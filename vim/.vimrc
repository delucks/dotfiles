"---------
" ~/.vimrc

"---------
" Settings

" basics
set nocompatible
set encoding=utf-8
set number
set secure
" ui
set ruler
set noshowmode
set lazyredraw
set showcmd
" remove hit-enter prompts for intro
set shortmess+=I
" for :set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,eol:→
" theming
syntax on
set synmaxcol=300 " don't render lines > 300 chars
colorscheme delucks
if !has('gui_running')
  set t_Co=256
endif

" enables a completion menu over the statusline
set wildmenu
set wildmode=full

" searching
set ignorecase
set smartcase
set incsearch
set hlsearch

" editing
set autoindent
set foldmethod=marker
set history=100
set splitright
set laststatus=2
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
set tw=0

" misc
let g:sh_no_error = 1
let g:markdown_fenced_languages = ['python', 'java', 'sh', 'vim', 'clojure']

" ignore the following files (or give low preference)
set suffixes=.bak,.pyc,.swp,.o,.out,.pyo,.jpg,.png,.gif,.class
let g:netrw_liststyle=2
if executable("rg")
  set grepprg=ag
elseif executable("ack")
  set grepprg=ack
endif

if v:version >= 703
  set colorcolumn=80
  set undodir=~/.vim/undo
  set undofile
  set undolevels=1000 "max number of changes that can be undone
  set undoreload=10000 "max number lines to save for undo on buffer reload
endif

"--------
" Plugins

call plug#begin('~/.vim/plugins')
Plug 'fatih/vim-go', { 'for': 'go' }                  " enables gofmt on :w
Plug 'vim-airline/vim-airline'                        " draws buffers in tabline and colorizes the statusline
Plug 'ctrlpvim/ctrlp.vim'                             " fast fuzzy find buffer menu
Plug 'deris/vim-shot-f'                               " highlights the first match of a character in a line for f/t commands
Plug 'mhinz/vim-signify'                              " display version control hints
Plug 'junegunn/limelight.vim'                         " syntax highlight only the current paragraph
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }  " syntax hightlight clojure
Plug 'tpope/vim-fugitive'                             " I only use :Gblame but that is useful
Plug 'benmills/vimux'                                 " send commands to tmux
if executable("elixir")
  Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }  " better support
endif
call plug#end()

"---------------
" Plugin Options

" Signify
let g:signify_vcs_list = [ 'git', 'svn' ]
let g:signify_line_highlight = 0
let g:signify_sign_change = '~'
let g:signify_sign_delete = '-'

" CtrlP options
let g:ctrlp_map = '<Leader>q'
let g:ctrlp_cmd = 'CtrlP'

" limelight.vim

nmap <silent> gl :Limelight!!<CR>
xmap gl <Plug>(Limelight)
let g:limelight_conceal_ctermfg = 8
let g:limelight_paragraph_span = 0

" Buftabline
let g:buftabline_show=1
let g:buftabline_numbers=0
let g:buftabline_separators=0

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='dark'
let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

"---------
" Keybinds

" Enhancements
nmap j gj
nmap k gk
nnoremap <Space> :
nnoremap n nzz
nnoremap J mzJ`z
cmap w!! %!sudo tee > /dev/null %
" improve my search and replace workflow
nmap S :%s//g<LEFT><LEFT>
nmap <expr>  M  ':%s/' . @/ . '//g<LEFT><LEFT>'

" get rid of some keys
nnoremap <F1> <nop>
nnoremap Q <nop>

" Buffer Manipulation
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


" Misc
nmap <F6> :r!xclip -o <CR>
vmap <F6> :!xclip -f -sel clip<CR>

" this allows you to change the next and previous matches for the current word
nnoremap c* *Ncgn
nnoremap c# #NcgN

"-------
" Macros

" Transform ~/.Xresources style colors into exported variables
let @x = '0xiexport l5~f:df#i="#A"j'
" Transform hlwm keybinds into i3 keybinds
let @h = '0c2wbindsymwf wcwexec'
" Insert a line of all = the same length as the current one
let @e = 'yyp:s/./=/g'

" Make the current buffer suitable for direct copy-pasting out of a terminal window
function! CopyMode()
  setlocal number!
  setlocal relativenumber!
  setlocal ruler!
  setlocal showcmd!
  :SignifyToggle
  :AirlineToggle
  if &laststatus
    set laststatus=0
  else
    set laststatus=2
  endif
endfunction


"---------------
" Leader Mappings
"
"   n         CopyMode
nnoremap <Leader>n :call CopyMode()<CR>
" vimux Commands
"   tc        Tmux Command
nmap <Leader>tc :VimuxPromptCommand<CR>
"   tl        Tmux Last
nmap <Leader>tl :VimuxRunLastCommand<CR>
"   tx        Tmux interrupt
nmap <Leader>tx :VimuxInterruptRunner<CR>
"   tz        Tmux Zoom
nmap <Leader>tz :VimuxZoomRunner<CR>
"   ts        Tmux shell (jump to runner)
nmap <Leader>ts :VimuxInspectRunner<CR>
"   v         version control prev hunk
"   V         version control next hunk
nmap <Leader>v <plug>(signify-next-hunk)
nmap <Leader>V <plug>(signify-prev-hunk)
"   q         CtrlP from current dir
"   a         CtrlP Buffers
nnoremap <silent> <Leader>q :CtrlP<CR>
nnoremap <silent> <Leader>a :CtrlPBuffer<CR>
"   e         Explore menu in a split
nnoremap <silent> <Leader>e :Lexplore<CR>
"   s         Recompute syntax highlighting
nnoremap <silent> <Leader>s :syntax sync fromstart<CR>
"   w         Prev buffer
"   b         Next buffer
nnoremap <silent> <Leader>w :bn<CR>
nnoremap <silent> <Leader>b :bp<CR>
"   c         Close buffer
nnoremap <silent> <Leader>c :bd<CR>
"   h         Focus one buffer to the left
"   j         Focus one buffer down
"   k         Focus one buffer up
"   l         Focus one buffer to the right
nmap <Leader>h <C-W><C-H>
nmap <Leader>j <C-W><C-J>
nmap <Leader>k <C-W><C-K>
nmap <Leader>l <C-W><C-L>
"   H         Move buffer to the left
"   J         Move buffer down
"   K         Move buffer up
"   L         Move buffer to the right
nmap <Leader><S-h> :winc H<CR>
nmap <Leader><S-j> :winc J<CR>
nmap <Leader><S-k> :winc K<CR>
nmap <Leader><S-l> :winc L<CR>
"   /         Clear search highlight
nnoremap <silent> <Leader>/ :noh<CR>

"-------------
" Autocommands

" Reload ~/.vimrc after saving
autocmd! bufwritepost .vimrc source %
" jump to last used position in every file
autocmd bufreadpost * normal `"
" resize windows when they are resized
autocmd VimResized * wincmd =

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
autocmd FileType text
  \ set spell |
  \ set complete+=kspell
autocmd FileType java
  \ setlocal shiftwidth=4 |
  \ setlocal tabstop=4 |
  \ map <Leader>z :!javac "%:p" <CR>
autocmd BufRead,BufNewFile *.clj
  \ set filetype=clojure
autocmd FileType vim
  \ map K :execute('vert help ' . expand("<cword>"))<CR><C-w><C-h>
autocmd BufRead,BufNewFile *.md
  \ set filetype=markdown |
  \ set spell |
  \ set complete+=kspell

" Allow for each machine to override global settings
if !empty(glob("~/.localvimrc"))
  source ~/.localvimrc
endif
