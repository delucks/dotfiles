" Colorscheme created with ColorSchemeEditor v1.2.2
"Name: ElegantBritWhite
"Maintainer: Robert Kania <kania@gdi.cz>
"Version: 0.1
"Last Change: 2010 Feb 24
"License: BSD License

set background=light
if version > 580
highlight clear
if exists("syntax_on")
syntax reset
endif
endif
let g:colors_name = "ElegantBritWhite"

if v:version >= 700
highlight CursorColumn guibg=#7E7F7F gui=NONE
highlight CursorLine guibg=#E2E2E2 gui=NONE
highlight Pmenu guifg=#262729 guibg=#E2E2E2 gui=NONE
highlight PmenuSel guifg=#262729 guibg=#E68924 gui=NONE
highlight PmenuSbar guifg=#CCCCCC guibg=#CCCCCC gui=NONE
highlight PmenuThumb guifg=Black guibg=#AAAAAA gui=reverse
highlight TabLine guibg=#FF00E7 gui=underline
highlight TabLineFill gui=reverse
highlight TabLineSel gui=bold
if has('spell')
highlight SpellBad gui=undercurl
highlight SpellCap gui=undercurl
highlight SpellLocal gui=undercurl
highlight SpellRare gui=undercurl
endif
endif
highlight Cursor guifg=#262729 guibg=#E04613 gui=NONE
highlight CursorIM guifg=#262729 guibg=#E04613 gui=NONE
highlight DiffAdd guibg=LightBlue gui=NONE
highlight DiffChange guifg=#E04613 guibg=#E2E2E2 gui=NONE
highlight DiffDelete guifg=#262729 guibg=#6C9EAB gui=NONE
highlight DiffText guifg=#E04613 guibg=#FBE6E0 gui=NONE
highlight Directory guifg=#6C9EAB gui=NONE
highlight ErrorMsg guifg=#E04613 guibg=#FEFEFE gui=bold
highlight FoldColumn guifg=#E2E2E2 guibg=#FEFEFE gui=NONE
highlight Folded guifg=#414141 guibg=#E2E2E2 gui=NONE
highlight IncSearch guifg=#FBE6E0 guibg=#E68924 gui=underline
highlight LineNr guifg=#E2E2E2 gui=NONE
highlight MatchParen guifg=#FFFFFF guibg=#277699 gui=bold
highlight ModeMsg guifg=#277699 gui=bold
highlight MoreMsg guifg=#6C9EAB gui=bold
highlight NonText guifg=#000000 guibg=#FEFEFE gui=bold
highlight Normal guifg=#262729 guibg=#FEFEFE gui=NONE
highlight Question guifg=#277699 gui=bold
highlight Search guifg=#FBE6E0 guibg=#E04613 gui=NONE
highlight SignColumn guifg=#FF00E7 guibg=bg gui=NONE
highlight ColorColumn guibg=#fafafa
highlight SpecialKey guifg=#EE0000 guibg=bg gui=NONE
highlight StatusLine guifg=white guibg=#277699 gui=bold
highlight StatusLineNC guifg=#E9E9F4 guibg=#277699 gui=NONE
highlight Title guifg=#7E7F7F gui=NONE
highlight VertSplit gui=reverse
highlight Visual guifg=#262729 guibg=#E04613 gui=NONE
highlight VisualNOS guifg=#262729 guibg=#E04613 gui=underline
highlight WarningMsg guifg=Red gui=NONE
highlight WildMenu guifg=#56A0EE guibg=#E9E9F4 gui=underline
highlight link Boolean Constant
highlight link Character Constant
highlight Comment guifg=#6C9EAB gui=NONE
highlight link Conditional Statement
highlight Constant guifg=#7E7F7F gui=NONE
highlight link Debug Special
highlight link Define PreProc
highlight link Delimiter Special
highlight Error guifg=#E04613 guibg=#262729 gui=bold
highlight link Exception Statement
highlight link Float Number
highlight link Function Identifier
highlight Identifier guifg=#262729 gui=NONE
highlight Ignore guifg=bg gui=NONE
highlight link Include PreProc
highlight link Keyword Statement
highlight link Label Statement
highlight link Macro PreProc
highlight Number guifg=#E04613 gui=NONE
highlight link Operator Statement
highlight link PreCondit PreProc
highlight PreProc guifg=#E04613 gui=NONE
highlight link Repeat Statement
highlight Special guifg=#277699 gui=NONE
highlight link SpecialChar Special
highlight link SpecialComment Special
highlight Statement guifg=#E68924 gui=NONE
highlight link StorageClass Type
highlight link String Constant
highlight link Structure Type
highlight Tag guifg=DarkGreen gui=NONE
highlight Todo guifg=#FFFFFF guibg=#E04613 gui=NONE
highlight Type guifg=#7E7F7F gui=NONE
highlight link Typedef Type
highlight Underlined guifg=#277699 gui=underline


"ColorScheme metadata{{{
if v:version >= 700
let g:ElegantBritWhite_Metadata = {
\"Palette" : "#000000:#FFFFFF:#FFFFFF:#FFFFFF:#277699:#6C9EAB:#FBE6E0:#E68924:#E04613:#262729:#FF00E7:#1014AD:#B91F49:#1071CE:#EE0000:#FEFEFE:#E2E2E2:#7E7F7F:#414141:#393B3D",
\"Maintainer" : "Robert Kania",
\"Name" : "ElegantBritWhite",
\"License" : ["BSD License",
\],
\"Version" : "0.1",
\"Email" : "kania@gdi.cz",
\"Last Change" : "2010 Feb 24",
\}
endif
"}}}
" vim:set foldmethod=marker expandtab filetype=vim:
