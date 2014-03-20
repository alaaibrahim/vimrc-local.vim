" File: vimrc-local.vim
" Author: Ala Ibrahim
" Description: 
" Last Modified: February 24, 2014

if exists('did_vimrc_local') || &cp || version < 700
    finish
endif
let did_vimrc_local = 1

" Do we have local vimrc?
if filereadable('.vimrc.local')
    " If so, go ahead and load it.
    source .vimrc.local
else
    " Are we in a git repo
    let dir = getcwd()
    exec 'cd "' . expand("%:p:h") . '"'
    let gitdir = system('git rev-parse --show-toplevel')
    if !v:shell_error
        " We are in a git repo
        exec 'let vimfile = "' . split(matchstr(gitdir, "\\S\\+\n"),"\n")[0] . '/' . '.vimrc.local"'
        if filereadable(vimfile)
            exec 'source ' . vimfile
        endif
    endif
    exec 'cd "' . dir . '"'
endif
