" jgy-256 - a Vim color scheme for 256-colour terminals
" Name:        jgy-256.vim
" Maintainer:  Joe Yates
" License:     MIT

" Setup " {{{
" This is a terminal-only colorscheme
if has('gui_running')
  finish
endif

highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "jgy-256"
set t_Co=256
" }}}

" Editor " {{{
" N.B. setting ctermbg for Normal updates the 'background' setting
highlight Normal                    ctermfg=7       ctermbg=236
highlight CursorLine     cterm=NONE                 ctermbg=235
highlight ColorColumn                               ctermbg=235
highlight Search                    ctermfg=233     ctermbg=172
highlight Visual                    ctermfg=bg      ctermbg=fg

" Popup menu
highlight Pmenu                     ctermfg=234     ctermbg=12
highlight PmenuSel                  ctermfg=fg      ctermbg=208
" }}}
" Global syntax " {{{
highlight Comment                   ctermfg=102
highlight Conditional               ctermfg=34
highlight Constant                  ctermfg=37
highlight Define                    ctermfg=247
highlight Delimiter                 ctermfg=37
highlight Function                  ctermfg=39
highlight Keyword                   ctermfg=2
highlight Identifier                ctermfg=38
highlight Include                   ctermfg=130
highlight PreProc                   ctermfg=166
highlight Statement                 ctermfg=106
highlight String                    ctermfg=35
highlight Todo                      ctermfg=169     ctermbg=NONE
highlight Type                      ctermfg=178
" }}}
" Ruby " {{{
" Types

" rubyString (-> String)
"`rb 'single'
"`rb "double"

" rubyStringDelimiter (-> Delimiter)
"`rb ''
"`rb "with #{interpolated} value"

" rubyInteger (-> Number)
"`rb 123

" rubyFloat (-> Float -> Number)
"`rb 1.23

" rubySymbol
highlight rubySymbol                ctermfg=97
"`rb :foo

" Identifiers

" rubyPseudoVariable (-> Constant)
"`rb nil self __FILE__ __LINE__

" rubyPredefinedConstant (-> rubyPredefinedIdentifier -> Identifier)
"`rb STDOUT

" rubyConstant (-> Type)
"`rb class Foo; end

" rubyAttribute (-> Statement)
"`rb attr_reader :foo
"`rb attr_writer :foo
"`rb attr_accessor :foo

" Comments

" rubyComment (-> Comment)
"`rb # A comment

" rubyTodo (-> Todo)
"`rb # TODO FIXME NOTE OPTIMIZE XXX

" rubySharpBang (-> PreProc)
" (can't show example)

" rubyInclude (-> Include)
"`rb require 'foo'
"`rb include Foo

" rubyKeyword (-> Keyword)
"`rb callcc
"`rb caller
"`rb lambda {}
"`rb proc {}

" rubyControl
highlight rubyControl               ctermfg=34
"`rb do; end
"`rb return

" rubyConditionalModifier (-> rubyConditional)
"`rb :foo if :bar
"`rb :bar unless :foo

" rubyCaseExpression (-> rubyConditional)
"`rb case; end

" rubyConditional (-> Conditional)
"`rb if :foo; end

" rubyDefine 'def'
highlight rubyDefine                ctermfg=145
"`rb def foo; end

" rubyClass 'class' (-> rubyDefine)
"`rb class Foo; end

" rubyModule 'module' (-> rubyDefine)
"`rb module Foo; end

" rubyFunction (function names) (-> Function)
"`rb def foo; end
" }}}

" Inline colouring for syntax examples "{{{
" Within this file, we want previews of colours.
" The following sets up comment syntax for certain languages,
" so that the highlight settings can be followed by examples of their effects.
"
" The function TextEnableCodeSnip is taken from
" http://vim.wikia.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

" Add a colour for the hidden text used in this file
highlight Hidden                    ctermfg=bg      ctermbg=bg

function! CodeSnippetsInsideVimFiles() abort
  call TextEnableCodeSnip('ruby', '\"`rb', '$', 'Hidden')
endfunction

" Add snippet colouring to all .vim files
autocmd FileType vim call CodeSnippetsInsideVimFiles()
" }}}
" Footer " {{{
" vim: foldmethod=marker:foldlevel=0
" }}}
