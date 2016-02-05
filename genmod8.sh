#!/bin/bash
#
# A script to generate mod8 vim theme and Xresrources from base16 themes
#
# easysid Friday, 05 February 2016 15:31 IST

if [[ ! -f $1 ]]; then
    echo "Cannot read file - $1"
    exit 101
fi

basetheme=$(basename ${1})
declare -A colors

while read -r num hex; do
    colors[$num]="$hex"
done < <(sed -nre 's/let s:gui(\w\w) = "(\w{6})".*/\1 \2/gp' ${1})

themename="mod8-${basetheme}"
resourename="${basetheme}.Xresources"

# Put in templates
#
#########################
# .Xresources template  #
#########################
#
echo "Generating .Xresources - Storing in $resourename"
echo
cat << EOF > ${resourename}
! .Xresources for mod8 vim - Generated using genmod8.sh

! Color palette for ${basetheme}
#define base00 #${colors[00]}
#define base01 #${colors[01]}
#define base02 #${colors[02]}
#define base03 #${colors[03]}
#define base04 #${colors[04]}
#define base05 #${colors[05]}
#define base06 #${colors[06]}
#define base07 #${colors[07]}
#define base08 #${colors[08]}
#define base09 #${colors[09]}
#define base0A #${colors[0A]}
#define base0B #${colors[0B]}
#define base0C #${colors[0C]}
#define base0D #${colors[0D]}
#define base0E #${colors[0E]}
#define base0F #${colors[0F]}

! Slightly modified terminal color definitions from the default base16 Xresources
! You should not need to make any changes below.
*.foreground:   base05
*.background:   base00
*.cursorColor:  base05

*.color0:       base01
*.color1:       base08
*.color2:       base0B
*.color3:       base0A
*.color4:       base0D
*.color5:       base0E
*.color6:       base0C
*.color7:       base03

*.color8:       base02
*.color9:       base09
*.color10:      base0B
*.color11:      base0A
*.color12:      base0D
*.color13:      base0E
*.color14:      base0F
*.color15:      base04

! man pages. Change according to taste
*colorBD: 1
*colorUL: 4

! vim: ft=xdefaults
EOF
#
#########################
# vim theme template    #
#########################
#
echo "Generating vim colorscheme - Storing in $themename"
echo
cat << EOF > ${themename}
" mod8 vim theme
" modified version of base16 (https://github.com/chriskempson/base16)
" --------------------------------------------------------------------------
" * Dark theme only
" * Free up unused colors for .Xresources
"

" Theme setup
let g:colors_name = "mod8"
hi clear
syntax reset
set background=dark

" GUI color definitions
let s:gui00 = "${colors[00]}"
let s:gui01 = "${colors[01]}"
let s:gui02 = "${colors[02]}"
let s:gui03 = "${colors[03]}"
let s:gui04 = "${colors[04]}"
let s:gui05 = "${colors[05]}"
let s:gui06 = "${colors[06]}"
let s:gui07 = "${colors[07]}"
let s:gui08 = "${colors[08]}"
let s:gui09 = "${colors[09]}"
let s:gui0A = "${colors[0A]}"
let s:gui0B = "${colors[0B]}"
let s:gui0C = "${colors[0C]}"
let s:gui0D = "${colors[0D]}"
let s:gui0E = "${colors[0E]}"
let s:gui0F = "${colors[0F]}"

" Terminal color definitions
" This is where we change certain definitions to free up colors
let s:cterm00 = "00"        " unused
let s:cterm03 = "07"
let s:cterm05 = "07"        " unused
let s:cterm07 = "15"        " unused
let s:cterm08 = "01"
let s:cterm0A = "03"
let s:cterm0B = "02"
let s:cterm0C = "06"
let s:cterm0D = "04"
let s:cterm0E = "05"
let s:cterm01 = "00"
let s:cterm02 = "08"
let s:cterm04 = "15"
let s:cterm06 = "13"        " unused
let s:cterm09 = "09"
let s:cterm0F = "14"

" Highlighting function
fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=#" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=#" . a:guibg
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun

" Vim editor colors
call <sid>hi("Bold",          "", "", "", "", "bold")
call <sid>hi("Debug",         s:gui08, "", s:cterm08, "", "")
call <sid>hi("Directory",     s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("Error",         s:gui08, "", s:cterm08, "NONE", "REVERSE")
call <sid>hi("ErrorMsg",      s:gui08, s:gui00, s:cterm08, "NONE", "")
call <sid>hi("Exception",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("FoldColumn",    "", s:gui01, "", s:cterm01, "")
call <sid>hi("Folded",        s:gui03, s:gui01, s:cterm03, s:cterm01, "")
call <sid>hi("IncSearch",     s:gui01, s:gui09, s:cterm01, s:cterm09, "none")
call <sid>hi("Italic",        "", "", "", "", "none")
call <sid>hi("Macro",         s:gui08, "", s:cterm08, "", "")
call <sid>hi("MatchParen",    s:gui00, s:gui03, s:cterm00, s:cterm03,  "")
call <sid>hi("ModeMsg",       s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("MoreMsg",       s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("Question",      s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("Search",        s:gui03, s:gui0A, s:cterm03, s:cterm0A,  "")
call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "")
call <sid>hi("TooLong",       s:gui08, "", s:cterm08, "", "")
call <sid>hi("Underlined",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("Visual",        "", s:gui02, "", s:cterm02, "")
call <sid>hi("VisualNOS",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("WarningMsg",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("WildMenu",      s:gui08, "", s:cterm08, "", "")
call <sid>hi("Title",         s:gui0D, "", s:cterm0D, "", "none")
call <sid>hi("Conceal",       s:gui0D, s:gui00, s:cterm0D, "", "")
call <sid>hi("Cursor",        s:gui00, s:gui05, "", "", "")
call <sid>hi("NonText",       s:gui03, "", s:cterm03, "", "")
call <sid>hi("Normal",        s:gui05, s:gui00, "", "", "")
call <sid>hi("LineNr",        s:gui03, s:gui01, s:cterm03, s:cterm01, "")
call <sid>hi("SignColumn",    s:gui03, s:gui01, s:cterm03, s:cterm01, "")
call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "")
call <sid>hi("StatusLine",    s:gui04, s:gui02, s:cterm04, s:cterm02, "none")
call <sid>hi("StatusLineNC",  s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("VertSplit",     s:gui02, s:gui02, s:cterm02, s:cterm02, "none")
call <sid>hi("ColorColumn",   "", s:gui01, "", s:cterm01, "none")
call <sid>hi("CursorColumn",  "", s:gui01, "", s:cterm01, "none")
call <sid>hi("CursorLine",    "", s:gui01, "", s:cterm01, "none")
call <sid>hi("CursorLineNr",  s:gui03, s:gui01, s:cterm03, s:cterm01, "")
call <sid>hi("PMenu",         s:gui04, s:gui01, s:cterm04, s:cterm01, "none")
call <sid>hi("PMenuSel",      s:gui01, s:gui04, s:cterm01, s:cterm04, "")
call <sid>hi("TabLine",       s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("TabLineFill",   s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("TabLineSel",    s:gui0B, s:gui01, s:cterm0B, s:cterm01, "none")

" Standard syntax highlighting
call <sid>hi("Boolean",      s:gui09, "", s:cterm09, "", "")
call <sid>hi("Character",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("Comment",      s:gui03, "", s:cterm03, "", "")
call <sid>hi("Conditional",  s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("Constant",     s:gui09, "", s:cterm09, "", "")
call <sid>hi("Define",       s:gui0E, "", s:cterm0E, "", "none")
call <sid>hi("Delimiter",    s:gui0F, "", s:cterm0F, "", "")
call <sid>hi("Float",        s:gui09, "", s:cterm09, "", "")
call <sid>hi("Function",     s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("Identifier",   s:gui08, "", s:cterm08, "", "none")
call <sid>hi("Include",      s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("Keyword",      s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("Label",        s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("Number",       s:gui09, "", s:cterm09, "", "")
call <sid>hi("Operator",     s:gui05, "", "", "", "none")
call <sid>hi("PreProc",      s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("Repeat",       s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("Special",      s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("SpecialChar",  s:gui0F, "", s:cterm0F, "", "")
call <sid>hi("Statement",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("StorageClass", s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("String",       s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("Structure",    s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("Tag",          s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("Todo",         s:gui0A, s:gui01, s:cterm0A, s:cterm01, "")
call <sid>hi("Type",         s:gui0A, "", s:cterm0A, "", "none")
call <sid>hi("Typedef",      s:gui0A, "", s:cterm0A, "", "")

" C highlighting
call <sid>hi("cOperator",   s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("cPreCondit",  s:gui0E, "", s:cterm0E, "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:gui05, "", "", "", "")
call <sid>hi("cssClassName",   s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("cssColor",       s:gui0C, "", s:cterm0C, "", "")

" Diff highlighting
call <sid>hi("DiffAdd",      s:gui0B, s:gui01,  s:cterm0B, s:cterm01, "")
call <sid>hi("DiffChange",   s:gui03, s:gui01,  s:cterm03, s:cterm01, "")
call <sid>hi("DiffDelete",   s:gui08, s:gui01,  s:cterm08, s:cterm01, "")
call <sid>hi("DiffText",     s:gui0D, s:gui01,  s:cterm0D, s:cterm01, "")
call <sid>hi("DiffAdded",    s:gui0B, s:gui00,  s:cterm0B, "", "")
call <sid>hi("DiffFile",     s:gui08, s:gui00,  s:cterm08, "", "")
call <sid>hi("DiffNewFile",  s:gui0B, s:gui00,  s:cterm0B, "", "")
call <sid>hi("DiffLine",     s:gui0D, s:gui00,  s:cterm0D, "", "")
call <sid>hi("DiffRemoved",  s:gui08, s:gui00,  s:cterm08, "", "")

" Git highlighting
call <sid>hi("gitCommitOverflow",  s:gui08, "", s:cterm08, "", "")
call <sid>hi("gitCommitSummary",   s:gui0B, "", s:cterm0B, "", "")

" GitGutter highlighting
call <sid>hi("GitGutterAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "")
call <sid>hi("GitGutterChange",  s:gui0D, s:gui01, s:cterm0D, s:cterm01, "")
call <sid>hi("GitGutterDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "")
call <sid>hi("GitGutterChangeDelete",  s:gui0E, s:gui01, s:cterm0E, s:cterm01, "")

" HTML highlighting
call <sid>hi("htmlBold",    s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("htmlItalic",  s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("htmlEndTag",  s:gui05, "", "", "", "")
call <sid>hi("htmlTag",     s:gui05, "", "", "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        s:gui05, "", "", "", "")
call <sid>hi("javaScriptBraces",  s:gui05, "", "", "", "")
call <sid>hi("javaScriptNumber",  s:gui09, "", s:cterm09, "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("markdownError",             s:gui05, s:gui00, "", "", "")
call <sid>hi("markdownCodeBlock",         s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("markdownHeadingDelimiter",  s:gui0D, "", s:cterm0D, "", "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("NERDTreeExecFile",  s:gui05, "", "", "", "")

" PHP highlighting
call <sid>hi("phpMemberSelector",  s:gui05, "", "", "", "")
call <sid>hi("phpComparison",      s:gui05, "", "", "", "")
call <sid>hi("phpParent",          s:gui05, "", "", "", "")

" Python highlighting
call <sid>hi("pythonOperator",  s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("pythonRepeat",    s:gui0E, "", s:cterm0E, "", "")

" Ruby highlighting
call <sid>hi("rubyAttribute",               s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("rubyConstant",                s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("rubyInterpolation",           s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("rubyInterpolationDelimiter",  s:gui0F, "", s:cterm0F, "", "")
call <sid>hi("rubyRegexp",                  s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("rubySymbol",                  s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("rubyStringDelimiter",         s:gui0B, "", s:cterm0B, "", "")

" SASS highlighting
call <sid>hi("sassidChar",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("sassClassChar",  s:gui09, "", s:cterm09, "", "")
call <sid>hi("sassInclude",    s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixing",     s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixinName",  s:gui0D, "", s:cterm0D, "", "")

" Signify highlighting
call <sid>hi("SignifySignAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "")
call <sid>hi("SignifySignChange",  s:gui0D, s:gui01, s:cterm0D, s:cterm01, "")
call <sid>hi("SignifySignDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "")

" Spelling highlighting
call <sid>hi("SpellBad",     "", s:gui00, s:cterm09, "NONE", "undercurl")
call <sid>hi("SpellLocal",   "", s:gui00, s:cterm0A, "NONE", "undercurl")
call <sid>hi("SpellCap",     "", s:gui00, s:cterm0A, "NONE", "undercurl")
call <sid>hi("SpellRare",    "", s:gui00, s:cterm0B, "NONE", "undercurl")

" Remove functions
delf <sid>hi

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
EOF

