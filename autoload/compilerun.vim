" Autoload: compilerun
" Provides compilerun#run() to compile/run the current buffer in a modern, safe way.

function! compilerun#run() abort
  " Basic checks
  if expand('%') ==# ''
    echoerr 'No file in buffer to run'
    return
  endif

  " File info
  let l:src = expand('%:p')
  let l:fname = expand('%:t')
  let l:base = expand('%:t:r')
  let l:dir = expand('%:p:h')
  let l:ft = &filetype

  " Platform detection
  if has('win32') || has('win64') || has('win16')
    let l:platform = 'windows'
  elseif exists('$WSL_DISTRO_NAME')
    let l:platform = 'wsl'
  else
    let l:uname = substitute(system('uname 2>/dev/null'), "\n", "", "")
    if l:uname =~? 'Darwin'
      let l:platform = 'mac'
    elseif l:uname =~? 'Linux'
      let l:platform = 'linux'
    else
      let l:platform = 'unix'
    endif
  endif

  " Utility for safe escaping
  function! s:esc(x) abort
    return shellescape(a:x)
  endfunction

  " Handler table: each entry is a list of commands run sequentially (only if prior succeed)
  let s:handlers = {
  \ 'c':    ['cc {src} -o {out}', '{run_cmd}'],
  \ 'cpp':  ['c++ {src} -o {out}', '{run_cmd}'],
  \ 'java': ['javac {src}', 'java -cp {dir} {class}'],
  \ 'python': ['python3 {src}'],
  \ 'sh':   ['bash {src}'],
  \ 'ruby': ['ruby {src}'],
  \ 'lua':  ['lua {src}'],
  \ 'rust': ['rustc {src} -o {out}', '{run_cmd}'],
  \ 'swift': ['swiftc {src} -o {out}', '{run_cmd}'],
  \ 'go':   ['go build -o {out} {src}', '{run_cmd}'],
  \ 'zig':  ['zig build-exe -O ReleaseFast -o {out} {src}', '{run_cmd}'],
  \ 'html': ['{open_cmd}']
  \}

  if !has_key(s:handlers, l:ft)
    echo 'No handler for filetype: ' . l:ft
    return
  endif

  " Build replacements
  let l:out = l:base
  if l:platform ==# 'windows'
    let l:out = l:out . '.exe'
  endif

  if l:platform ==# 'mac'
    let l:open_cmd = 'open ' . s:esc(l:src)
  elseif l:platform ==# 'linux' || l:platform ==# 'unix' || l:platform ==# 'wsl'
    let l:open_cmd = 'xdg-open ' . s:esc(l:src)
  elseif l:platform ==# 'windows'
    let l:open_cmd = 'start "" ' . s:esc(l:src)
  else
    let l:open_cmd = 'xdg-open ' . s:esc(l:src)
  endif

  if l:platform ==# 'windows'
    let l:run_cmd = s:esc(l:out)
  else
    let l:run_cmd = './' . s:esc(l:out)
  endif

  let l:cmds = copy(s:handlers[l:ft])
  " Substitute placeholders
  for i in range(len(l:cmds))
    let l:cmds[i] = substitute(l:cmds[i], '{src}', s:esc(l:src), 'g')
    let l:cmds[i] = substitute(l:cmds[i], '{out}', s:esc(l:out), 'g')
    let l:cmds[i] = substitute(l:cmds[i], '{dir}', s:esc(l:dir), 'g')
    let l:cmds[i] = substitute(l:cmds[i], '{class}', l:base, 'g')
    let l:cmds[i] = substitute(l:cmds[i], '{open_cmd}', l:open_cmd, 'g')
    let l:cmds[i] = substitute(l:cmds[i], '{run_cmd}', l:run_cmd, 'g')
  endfor

  " Join with ' && ' so subsequent commands only run on success
  let l:full = join(l:cmds, ' && ')

  " Save buffer before running
  silent keepjumps write

  " Prefer a terminal if available
  try
    if exists(':terminal')
      execute 'belowright split | terminal ' . l:full
      return
    endif
  catch
  endtry

  " Fallback to jobstart if available
  if exists('*jobstart')
    call jobstart(l:full, {'detach': v:true})
    echo 'Launched: ' . l:full
    return
  endif

  " Final fallback: run synchronously and show output in a quickfix list
  let l:out = systemlist(l:full)
  if v:shell_error
    call setqflist(map(l:out, '{"text": v:val}'))
    copen
  else
    echo 'Command finished successfully'
  endif
endfunction
