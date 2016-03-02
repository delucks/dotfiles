" Just terminal. Screw your GUI
" Maintainer:	      delucks <me@jamesluck.com>
" Last Change:	    03/02/2016
" License: 		      GNU Public License (GPL) v2

highlight clear Normal
set background&

" Remove all existing highlighting and set the defaults.
highlight clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "delucks"

"""""
" vim

hi Search           cterm=bold ctermbg=7 ctermfg=0
hi IncSearch        cterm=reverse ctermfg=15
hi SpecialKey	    	ctermfg=1
hi MatchParen       ctermbg=9 ctermfg=0
hi CursorLine     	ctermbg=none ctermfg=1
hi CursorColumn   	ctermbg=1
hi LineNr			      ctermfg=0
hi CursorLineNr     ctermfg=1 term=reverse
hi Visual			      cterm=reverse
hi VisualNOS		    cterm=bold
hi Directory		    ctermfg=9
hi Title			      ctermfg=0
" TODO: test this
hi Todo			  	    ctermbg=1 ctermfg=0
" the tildes and @ below text
hi NonText			    ctermfg=0
hi ModeMsg			    ctermfg=9 cterm=none
hi MoreMsg			    ctermfg=9 cterm=none
" active statusline
hi StatusLine		    ctermbg=0 cterm=none ctermfg=1
" not active statusline
hi StatusLineNC	    ctermbg=0 cterm=none ctermfg=7
hi VertSplit		    ctermbg=none cterm=none ctermfg=0
hi Pmenu            ctermbg=1 cterm=none
hi PmenuSel         ctermbg=0 cterm=none ctermfg=1
hi Folded			      ctermbg=7 cterm=none ctermfg=0
hi FoldColumn		    ctermfg=1

""""""
" diff

hi DiffAdd			    ctermbg=10 ctermfg=15
hi DiffChange		    ctermbg=4
hi DiffDelete		    ctermbg=1 ctermfg=15
hi DiffText			    ctermfg=0

""""""""
" syntax

hi Normal           ctermfg=7
hi Statement        ctermfg=1
hi Function         ctermfg=2
hi Conditional      ctermfg=9
hi Repeat           ctermfg=9
" logical operators
hi Operator         ctermfg=1
hi Exception        ctermfg=13
hi Include          ctermfg=13
hi Define           ctermfg=13
hi String           ctermfg=3
hi Comment          ctermfg=8
hi Special          ctermfg=1
hi Identifier       ctermfg=6
hi Constant         ctermfg=1

""""""""
" python

hi pythonBuiltin    ctermfg=9
hi pythonDecorator  ctermfg=8
hi pythonComment    ctermfg=8

"""""""""""
" gitgutter

hi clear SignColumn
hi GitGutterAdd     ctermfg=2
hi GitGutterDelete  ctermfg=1
hi GitGutterChange  ctermfg=13

""""""""""""
" buftabline

hi BufTabLineFill   ctermbg=111111 cterm=none
hi BufTabLineActive ctermbg=none ctermfg=7
hi BufTabLineCurrent ctermfg=1
hi BufTabLineHidden ctermbg=none ctermfg=8

"""""""
" ctrlp

hi CtrlPPrtCursor   ctermbg=none ctermfg=1
hi CtrlPMatch       ctermbg=none ctermfg=2
hi CtrlPNoEntries   ctermbg=7 ctermfg=0
