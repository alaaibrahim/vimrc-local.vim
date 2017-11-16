" File: vimrc-local.vim
" Author: Ala Ibrahim
" Description: 
" Last Modified: September 12, 2014

if exists('g:did_vimrc_local') || &compatible || v:version < 700
    finish
endif
let g:did_vimrc_local = 1

if has('autocmd')
    autocmd BufNewFile,BufRead .vimrc.local set filetype=vim
endif

" Do we have local vimrc?
if filereadable('.vimrc.local')
    " If so, go ahead and load it.
    source .vimrc.local
elseif executable('git')
    " Are we in a git repo
    let s:parent_dir = expand('%:p:h')
    if isdirectory(s:parent_dir)
        let s:gitdir = system('git rev-parse --show-toplevel -C ' . s:parent_dir)
        if !v:shell_error && s:gitdir !=# ''
            " We are in a git repo
            let s:vimfile = split(matchstr(s:gitdir, "\\S\\+\n"),"\n")[0] . '/.vimrc.local'
            if filereadable(s:vimfile)
                exec 'source ' . s:vimfile
            endif
        endif
    endif
endif
