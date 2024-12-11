" Title:        CompileRun
" Description:  A plugin to quickly compile and run scripts within Vim.
" Last Change:  10 December 2024
" Maintainer:   jacob-thompson <https://github.com/jacob-thompson>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_compilerun")
    finish
endif
let g:loaded_compilerun = 1

" Exposes the plugin's functions for use as commands in Vim.
command! -nargs=0 CompileRun call compilerun#CompileRun()
