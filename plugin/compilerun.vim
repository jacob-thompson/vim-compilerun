" Title:        CompileRun
" Description:  A plugin to quickly compile and run scripts within Vim.
" Last Change:  10 December 2024
" Maintainer:   jacob-thompson <https://github.com/jacob-thompson>

if exists("g:loaded_compilerun")
    finish
endif
let g:loaded_compilerun = 1

command! -nargs=0 CompileRun call CompileRun#CompileRun()
