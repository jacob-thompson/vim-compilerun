func! compilerun#CompileRun()
    if !exists("g:env")
        if has("win64") || has("win32") || has("win16")
            let g:env = "WINDOWS"
        else
            let g:env = toupper(substitute(system("uname"), "\n", "", ""))
        endif
    endif

    exec "w"

    if &filetype == "c"
        if g:env =~# "WINDOWS"
            exec "!gcc % -o %<.exe && time ./%<.exe && del %<.exe"
        else
            exec "!gcc % -o %< && time ./%< && rm %<"
    elseif &filetype == "cpp"
        if g:env =~# "WINDOWS"
            exec "!g++ % -o %<.exe && time ./%<.exe && del %<.exe"
        else
            exec "!g++ % -o %< && time ./%< && rm %<"
    elseif &filetype == "java"
        exec "!javac % && time java %"
    elseif &filetype == "sh"
        exec "!time bash %"
    elseif &filetype == "python"
        exec "!time python3 %"
    elseif &filetype == "ruby"
        exec "!time ruby %"
    elseif &filetype == "html"
        if g:env =~# "DARWIN"
            exec "!open % &"
        elseif g:env =~# "LINUX"
            exec "!xdg-open % &"
        elseif g:env =~# "WINDOWS" || g:env =~# "MINGW"
            exec "!start % &"
        elseif g:env =~# "CYGWIN"
            exec "!cygstart % &"
        else
            exec "!google-chrome % &"
        endif
    elseif &filetype == "go"
        exec "!go build %< && time go run %"
    elseif &filetype == "lua"
        exec "!time lua %"
    endif

endfunc
