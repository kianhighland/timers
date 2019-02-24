"Vim syntax file
"For a config file for the timers program I made
if exists("b:current_syntax")
  finish
endif
"syn match baseNumber '\d\d'
syn match defBase ':\d\d'
" nextgroup=baseNumber
syn match comment "#.*$"
let b:current_syntax = "timers"
hi def link defBase Constant
hi def link baseNumber Constant
hi def link comment Comment
