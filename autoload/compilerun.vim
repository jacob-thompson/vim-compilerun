func! CompileRun#CompileRun()
    exec "w"

    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp' || &filetype == 'cxx' || &filetype == 'cc'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %"
    elseif &filetype == 'sh'
        exec "!time bash %"
    elseif &filetype == 'python'
        exec "!time python3 %"
    elseif &filetype == 'html'
        if has('macunix')
            exec "!open % &"
        elseif has('unix')
            exec "!xdg-open % &"
        elseif has('win32') || has('win32unix')
            exec "!start % &"
        else
            exec "!google-chrome % &"
        endif
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'matlab'
        exec "!time octave %"
    endif

endfunc
