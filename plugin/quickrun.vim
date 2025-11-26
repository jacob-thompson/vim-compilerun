" Title:        QuickRun
" Description:  A plugin to quickly compile and run scripts within Vim.
" Last Change:  26 November 2025
" Maintainer:   jacob-thompson <https://github.com/jacob-thompson>

if exists("g:loaded_quickrun")
    finish
endif
let g:loaded_quickrun = 1

command! -nargs=0 Run call quickrun#run()
command! -nargs=0 QuickRun call quickrun#run()
