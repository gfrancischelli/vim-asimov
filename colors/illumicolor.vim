"  Illumicolor
"
" Modified from Steve Losh Badwolf 
"   http://stevelosh.com/projects/badwolf/
"
" Supporting code -------------------------------------------------------------
" Preamble {{{

if !has("gui_running") && &t_Co != 88 && &t_Co != 256
    finish
endif

set background=dark

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "illumicolor"

" if !exists("g:badwolf_html_link_underline") " {{{
"     let g:badwolf_html_link_underline = 1
" endif " }}}

" if !exists("g:badwolf_css_props_highlight") " {{{
"     let g:badwolf_css_props_highlight = 0
" endif " }}}

" }}}
" Palette {{{

let s:ilc = {}

" The most basic of all our colors is a slightly tweaked version of the Molokai
" Normal text.
let s:ilc.plain = ['d6d1d1', 15]

" Pure and simple.
let s:ilc.snow = ['ffffff', 15]
let s:ilc.coal = ['000000', 16]

" All of the Gravel colors are based on a brown from Clouds Midnight.
let s:ilc.brightgravel   = ['d9cec3', 252]
let s:ilc.lightgravel    = ['998f84', 245]
let s:ilc.gravel         = ['857f78', 243]
let s:ilc.mediumgravel   = ['666462', 241]
let s:ilc.deepgravel     = ['45413b', 238]
let s:ilc.deepergravel   = ['35322d', 236]
let s:ilc.darkgravel     = ['242321', 235]
let s:ilc.blackgravel    = ['171717', 233]
let s:ilc.blackestgravel = ['141413', 232]

" A color sampled from a highlight in a photo of a glass of Dale's Pale Ale on
" my desk.
let s:ilc.dalespale = ['fade3e', 221]

" A beautiful tan from Tomorrow Night.
let s:ilc.lightgreen = ['87c478', 222]

" Light yellow
let s:ilc.sandwisp = ['f4e694', 196]

let s:ilc.falcon = ['ffffff', 200]

" Another chewy accent, but use sparingly!
let s:ilc.saltwatersandwisp = ['8cffba', 121]

" The star of the show comes straight from Made of Code.
"
" You should almost never use this.  It should be used for things that denote
" 'where the user is', which basically consists of:
"
" * The cursor
" * A REPL prompt
let s:ilc.tardis = ['0a9dff', 39]

" This one's from Mustang, not Florida!
let s:ilc.orange = ['ffa724', 214]

" Dark red
let s:ilc.carmine = ['b03b3b', 200]

" A limier green from Getafe.
let s:ilc.lime = ['aeee00', 154]

" Rose's dress in The Idiot's Lantern.
let s:ilc.dress = ['ff9eb8', 211]

" Another play on the brown from Clouds Midnight.  I love that color.
let s:ilc.toffee = ['b88853', 137]

" Also based on that Clouds Midnight brown.
let s:ilc.coffee    = ['c7915b', 173]
let s:ilc.darkroast = ['88633f', 95]

" }}}
" Highlighting Function {{{
function! s:HL(group, fg, ...)
    " Arguments: group, guifg, guibg, gui, guisp

    let histring = 'hi ' . a:group . ' '

    if strlen(a:fg)
        if a:fg == 'fg'
            let histring .= 'guifg=fg ctermfg=fg '
        else
            let c = get(s:ilc, a:fg)
            let histring .= 'guifg=#' . c[0] . ' ctermfg=' . c[1] . ' '
        endif
    endif

    if a:0 >= 1 && strlen(a:1)
        if a:1 == 'bg'
            let histring .= 'guibg=bg ctermbg=bg '
        else
            let c = get(s:ilc, a:1)
            let histring .= 'guibg=#' . c[0] . ' ctermbg=' . c[1] . ' '
        endif
    endif

    if a:0 >= 2 && strlen(a:2)
        let histring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
    endif

    if a:0 >= 3 && strlen(a:3)
        let c = get(s:ilc, a:3)
        let histring .= 'guisp=#' . c[0] . ' '
    endif

    " echom histring

    execute histring
endfunction
" }}}
" Configuration Options {{{

if exists('g:badwolf_darkgutter') && g:badwolf_darkgutter
    let s:gutter = 'blackestgravel'
else
    let s:gutter = 'blackgravel'
endif

if exists('g:badwolf_tabline')
    if g:badwolf_tabline == 0
        let s:tabline = 'blackestgravel'
    elseif  g:badwolf_tabline == 1
        let s:tabline = 'blackgravel'
    elseif  g:badwolf_tabline == 2
        let s:tabline = 'darkgravel'
    elseif  g:badwolf_tabline == 3
        let s:tabline = 'deepgravel'
    else
        let s:tabline = 'blackestgravel'
    endif
else
    let s:tabline = 'blackgravel'
endif

" }}}
" Actual colorscheme ----------------------------------------------------------
" Vanilla Vim {{{
" General/UI {{{

call s:HL('Normal', 'plain', 'blackgravel')

call s:HL('Folded', 'mediumgravel', 'bg', 'none')

call s:HL('VertSplit', 'lightgravel', 'bg', 'none')

call s:HL('CursorLine',   '', 'darkgravel', 'none')
call s:HL('CursorColumn', '', 'darkgravel')
call s:HL('ColorColumn',  '', 'darkgravel')

call s:HL('TabLine', 'plain', s:tabline, 'none')
call s:HL('TabLineFill', 'plain', s:tabline, 'none')
call s:HL('TabLineSel', 'coal', 'tardis', 'none')

call s:HL('MatchParen', 'dalespale', 'darkgravel', 'none')

call s:HL('NonText',    'deepgravel', 'bg')
call s:HL('SpecialKey', 'deepgravel', 'bg')

call s:HL('Visual',    '',  'deepgravel')
call s:HL('VisualNOS', '',  'deepgravel')
" }}}
" Gutter {{{

call s:HL('LineNr',     'mediumgravel', s:gutter)
call s:HL('SignColumn', '',             s:gutter)
call s:HL('FoldColumn', 'mediumgravel', s:gutter)

" }}}
" Cursor {{{

call s:HL('Cursor',  'coal', 'tardis', 'bold')
call s:HL('vCursor', 'coal', 'tardis', 'bold')
call s:HL('iCursor', 'coal', 'tardis', 'none')

" }}}
" Syntax highlighting {{{

" Start with a simple base.
call s:HL('Special', 'plain')

" Comments are slightly brighter than folds, to make 'headers' easier to see.
call s:HL('Comment',        'gravel', '', 'italic')
call s:HL('Todo',           'snow', 'bg', 'italic')
call s:HL('SpecialComment', 'snow', 'bg', 'italic')

" Strings are a nice, pale straw color.  Nothing too fancy.
call s:HL('String', 'lightgreen')

" Control flow stuff is sandwisp.
call s:HL('Statement',   'sandwisp', '', 'none')

call s:HL('Identifier', 'carmine', '', 'none')
call s:HL('Function',   'carmine', '', 'none')

call s:HL('javaScriptIdentifier', 'carmine', '', 'none')
call s:HL('jsStorageClass', 'carmine', '', 'none')

call s:HL('javaScriptDocTags', 'carmine', '', 'none',)
" }}}
" }}}
