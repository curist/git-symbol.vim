autocmd VimEnter,BufEnter,BufWritePost * call SyncGitStatusSymbolColor()

" sync git status symbol color
hi User9 ctermfg=232 ctermbg=white cterm=reverse

" git status symbol
function! GitStatusSymbol()
  if !exists('b:git_dir')
    return ''
  endif
  return '⚡'
endfunction

" sync git status symbol color
function! SyncGitStatusSymbolColor()
  if !exists('b:git_dir')
    return
  endif
  let git_dir_is_dirty = system("git status -s --ignore-submodules=dirty")
  if git_dir_is_dirty != ''
    hi User9 ctermfg=232 ctermbg=red cterm=reverse,bold
  else
    hi User9 ctermfg=232 ctermbg=white cterm=reverse
  endif
endfunction

