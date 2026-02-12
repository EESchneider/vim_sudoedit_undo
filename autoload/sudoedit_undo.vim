function! sudoedit_undo#SudoeditHook()
    let real_files = split($SUDOEDIT_TARGET_FILES, '//')
    let args = argv()

    " BufReadPost has already run by the time this function is called with `nvim -c`
    call sudoedit_undo#ReadUndo(real_files[0])

    for i in range(len(real_files))
        let g:rautocmd = printf("autocmd BufReadPost %s call sudoedit_undo#ReadUndo('%s')",
                    \ fnameescape(args[i]), real_files[i])
        let g:wautocmd = printf("autocmd BufWritePost %s call sudoedit_undo#WriteUndo('%s')",
                    \ fnameescape(args[i]), real_files[i])
        exec g:rautocmd
        exec g:wautocmd
    endfor
endfunction

function! sudoedit_undo#ReadUndo(target_file)
    setlocal noundofile
    let target_undofile = undofile(a:target_file)
    if filereadable(target_undofile)
        silent exec 'rundo ' . fnameescape(target_undofile)
    endif
endfunction

function! sudoedit_undo#WriteUndo(target_file)
    setlocal noundofile
    let target_undofile = undofile(a:target_file)
    if !isdirectory(&undodir)
        call mkdir(&undodir)
    endif
    silent exec 'wundo ' . fnameescape(target_undofile)
endfunction

