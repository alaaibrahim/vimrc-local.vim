" File: vimrc-local.vim
" Author: Ala Ibrahim
" Description: 
" Last Modified: September 12, 2014

if exists('did_vimrc_local') || &cp || version < 700
    finish
endif
let did_vimrc_local = 1

if has("autocmd")
    autocmd BufNewFile,BufRead .vimrc.local set filetype=vim
endif

" Do we have local vimrc?
if filereadable('.vimrc.local')
    " If so, go ahead and load it.
    source .vimrc.local
else
    " Are we in a git repo
    let s:dir = getcwd()
    exec 'cd ' . fnameescape(expand("%:p:h"))
    let s:gitdir = system('git rev-parse --show-toplevel')
    if !v:shell_error && s:gitdir != ""
        " We are in a git repo
        exec 'let s:vimfile = "' . split(matchstr(s:gitdir, "\\S\\+\n"),"\n")[0] . '/' . '.vimrc.local"'
        if filereadable(s:vimfile)
            exec 'source ' . s:vimfile
        endif
    endif
    exec 'cd ' . fnameescape(s:dir)
endif
