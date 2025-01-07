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
            exec "!gcc % -o %<.exe && time ./%<.exe"
            exec "!del %<.exe"
        else
            exec "!gcc % -o %< && time ./%<"
            exec "!rm %<"
        endif
    elseif &filetype == "cpp"
        if g:env =~# "WINDOWS"
            exec "!g++ % -o %<.exe && time ./%<.exe"
            exec "!del %<.exe"
        else
            exec "!g++ % -o %< && time ./%<"
            exec "!rm %<"
        endif
    elseif &filetype == "java"
        exec "!javac % && time java %"
        if g:env =~# "WINDOWS"
            exec "!del %<.class"
        else
            exec "!rm %<.class"
        endif
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
    elseif &filetype == "zig"
        if g:env =~# "WINDOWS"
            exec "!zig build-exe % && time ./%<.exe"
            exec "!del %<.exe"
        else
            exec "!zig build-exe % && time ./%<"
            exec "!rm %< && rm %<.o"
        endif
    endif

endfunc
