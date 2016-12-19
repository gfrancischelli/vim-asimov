"  Asimov
"
" Built on top of Steve Losh's amazing Badwolf 
"   http://stevelosh.com/projects/badwolf/
"
" Palette --------------------------------------------------------------- {{{

let s:asm = {}

" The most basic of all our colors is a slightly tweaked version of the Molokai
" Normal text.
let s:asm.plain = ['bfc5c7', 254]

" Pure and simple.
let s:asm.snow = ['edfaf9', 15]
let s:asm.coal = ['000000', 16]

" All of the Gravel colors are based on a brown from Clouds Midnight.
let s:asm.brightgravel   = ['d9cec3', 252]
let s:asm.lightgravel    = ['998f84', 245]
let s:asm.gravel         = ['857f78', 243]
let s:asm.mediumgravel   = ['666462', 241]
let s:asm.deepgravel     = ['45413b', 238]
let s:asm.deepergravel   = ['35322d', 236]
let s:asm.darkgravel     = ['242321', 235]
let s:asm.darkblackgravel= ['191919', 234]
let s:asm.blackgravel    = ['171717', 233]
let s:asm.blackestgravel = ['141413', 232]

" A color sampled from a highlight in a photo of a glass of Dale's Pale Ale on
" my desk.
let s:asm.dalespale = ['fade3e', 223]

" A beautiful tan from Tomorrow Night.
let s:asm.lightgreen = ['8bc16f', 187]

" Light yellow
let s:asm.sandwisp = ['f4e694', 102]

" Light Blue
let s:asm.logan = ['9ba3c5', 37]

" Light Orange
let s:asm.waxflower = ['a678ac', 222]

" Ice
let s:asm.ice  = ['ffffd7', 160]

let s:asm.smaltblue = ['4C8385', 66]

" Another chewy accent, but use sparingly!
let s:asm.saltwatersandwisp = ['8cffba', 121]

" The star of the show comes straight from Made of Code.
"
" You should almost never use this.  It should be used for things that denote
" 'where the user is', which basically consists of:
"
" * The cursor
" * A REPL prompt
let s:asm.tardis = ['0a9dff', 39]

" Dark red
let s:asm.carmine = ['b03b3b', 140]

" Rose's dress in The Idiot's Lantern.
let s:asm.dress = ['f26767', 152]

" Another play on the brown from Clouds Midnight.  I love that color.
let s:asm.toffee = ['b88853', 137]

" Also based on that Clouds Midnight brown.
let s:asm.coffee    = ['c7915b', 173]
let s:asm.darkroast = ['88633f', 95]

" }}}
" Supporting code ------------------------------------------------------- {{{
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
" Highlighting Function {{{
function! s:HL(group, fg, ...)
    " Arguments: group, guifg, guibg, gui, guisp

    let histring = 'hi ' . a:group . ' '

    if strlen(a:fg)
        if a:fg == 'fg'
            let histring .= 'guifg=fg ctermfg=fg '
        else
            let c = get(s:asm, a:fg)
            let histring .= 'guifg=#' . c[0] . ' ctermfg=' . c[1] . ' '
        endif
    endif

    if a:0 >= 1 && strlen(a:1)
        if a:1 == 'bg'
            let histring .= 'guibg=bg ctermbg=bg '
        else
            let c = get(s:asm, a:1)
            let histring .= 'guibg=#' . c[0] . ' ctermbg=' . c[1] . ' '
        endif
    endif

    if a:0 >= 2 && strlen(a:2)
        let histring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
    endif

    if a:0 >= 3 && strlen(a:3)
        let c = get(s:asm, a:3)
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
" }}}

" Actual colorscheme --------------------------------------------------------
" Vim UI ---------------------------------------------------------------- {{{
" General/UI {{{

call s:HL('Normal', 'plain', 'blackgravel')

call s:HL('Search', 'tardis', 'blackgravel', 'none')

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

" Highlights only characters in 80th column
call s:HL('ColorColumn', '', 'darkgravel', 'none')
call matchadd('ColorColumn', '\%81v', 100)

" }}}
" Gutter {{{

call s:HL('LineNr',     'mediumgravel', s:gutter)
call s:HL('SignColumn', '',             s:gutter)
call s:HL('FoldColumn', 'mediumgravel', s:gutter)

" }}}
" Cursor {{{

call s:HL('Cursor',  'coal', 'ice', 'bold')
call s:HL('vCursor', 'coal', 'ice', 'bold')
call s:HL('iCursor', 'coal', 'ice', 'none')

" }}}
" }}}
" Vimscript ------------------------------------------------------------- {{{
call s:HL('vimCommand', 'ice', '', 'none')

" }}}
" Default Groups -------------------------------------------------------- {{{
" Start with a simple base.
call s:HL('Special', 'plain', '', 'none')

" Comments are slightly brighter than folds, to make 'headers' easier to see.
call s:HL('Comment',        'gravel', '', 'italic')
call s:HL('Todo',           'snow', 'bg', 'italic')
call s:HL('SpecialComment', 'snow', 'bg', 'italic')

" Strings are a nice, pale straw color.  Nothing too fancy.
call s:HL('String', 'lightgreen')

" Control flow stuff is sandwisp.
call s:HL('Statement',   'sandwisp', '', 'none')
call s:HL('Keyword',     'sandwisp', '', 'none')
call s:HL('Conditional', 'sandwisp', '', 'none')
call s:HL('Operator',    'lightgravel', '', 'none')
call s:HL('Label',       'sandwisp', '', 'none')
call s:HL('Repeat',      'sandwisp', '', 'none')
call s:HL('Define',      'carmine', '', 'none')
call s:HL('Type',        'dress', '', 'none')
call s:HL('Number', 'dalespale', '', 'none')

call s:HL('Identifier', 'sandwisp', '', 'none')
call s:HL('Function',   'sandwisp', '', 'none')


" }}}
" Html ------------------------------------------------------------------ {{{
call s:HL('htmlTitle',   'dalespale', '', 'none')
call s:HL('htmlAttrib', 'brightgravel', '', 'italic')
call s:HL('htmlEqual', 'lightgravel', '', 'italic')
call s:HL('htmlTag', 'deepgravel', '', 'none')
call s:HL('htmlEndTag', 'mediumgravel', '', 'none')
call s:HL('htmlTagName', 'gravel', '', 'none')

call s:HL('xmlAttrib', 'brightgravel', '', 'italic')
call s:HL('xmlEqual', 'lightgravel', '', 'italic')
call s:HL('xmlTag', 'deepgravel', '', 'none')
call s:HL('xmlEndTag', 'mediumgravel', '', 'none')
call s:HL('xmlTagName', 'gravel', '', 'none')

" }}}
" Css ------------------------------------------------------------------- {{{

call s:HL('cssNoise',       'gravel', '', 'none')
call s:HL('cssBraces',      'deepgravel', '', 'none')
call s:HL('cssClassName',   'ice', '', 'italic')
call s:HL('cssClassNameDot',  'lightgravel', '', 'italic')
call s:HL('cssUnitDecorators',  'darkroast', '', 'none')

call s:HL('cssPositioningAttr', 'coffee', '', 'none')
call s:HL('cssBoxProp',   'plain', '', 'none')
call s:HL('cssTextProp',  'plain', '', 'none')
call s:HL('cssFontProp',  'plain', '', 'none')
call s:HL('cssPositioningProp', 'plain', '', 'none')


" }}}
" Javascript ------------------------------------------------------------ {{{

" Basics
call s:HL('jsNumber',     'dalespale', '', 'italic')
call s:HL('jsOperator',   'waxflower', '', '')
call s:HL('jsNoise',  'mediumgravel', '', 'none')
call s:HL('jsSuper',  'smaltblue',  '', 'none')
call s:HL('jsThis',   'waxflower', '', 'none')

" Braces
call s:HL('jsBraces',  'brightgravel', '', 'none')
call s:HL('jsTemplateBraces', 'lightgravel', '', 'none')
call s:HL('jsDestructuringBraces', 'lightgravel', '', 'none')

" Function
call s:HL('jsFunction',       'ice', '', 'none')
call s:HL('jsFuncName',       'plain', '', 'none')
call s:HL('jsArrowFunction',  'dalespale', '', 'none')
call s:HL('jsFuncArgs',       'snow', '', 'italic')
call s:HL('jsFuncParens',     'gravel', '', 'none')
call s:HL('jsFuncCall',         'snow', '', 'none')
call s:HL('jsObjectFuncName',   'plain', '', 'none')
call s:HL('jsReturn',           'smaltblue', '', 'none')
call s:HL('jsArrowFuncArgs', 'snow', '', 'none')

" Js Conditionals
call s:HL('jsConditional',      'dalespale', '', 'none')
call s:HL('jsBooleanTrue',      'saltwatersandwisp', '', 'none')

" ES6
call s:HL('jsFrom',          'gravel', '', 'none')
call s:HL('jsImport',        'gravel', '', 'none')
call s:HL('jsExport', 'ice', '', 'italic')
call s:HL('jsExportDefault', 'lightgravel', '', 'none')
call s:HL('jsModuleKeyword', 'snow', '', 'italic')

call s:HL('javascriptReserved', 'ice', '', 'italic')

call s:HL('jsGlobalObjects', 'ice', '', 'none')

" Objects
call s:HL('jsObjectSeparator', 'mediumgravel', '', 'none')
call s:HL('jsObjectColon',      'lightgravel', '', 'none')
call s:HL('jsObjectKey',        'lightgravel', '', 'none')
call s:HL('javaScriptObjectKey', 'gravel', '', 'none')
call s:HL('jsStorageClass', 'carmine', '', 'none')
call s:HL('jsGlobalNodeObjects', 'ice', '', 'italic' )



" }}}
" Plugins --------------------------------------------------------------- {{{

" Indent Guides Plugin
set ts=2 sw=2 et
let g:indent_guides_guide_size=2
call s:HL('IndentGuidesOdd', '', 'blackgravel', 'none')
call s:HL('IndentGuidesEven', '', 'darkblackgravel', 'none')


" }}}
