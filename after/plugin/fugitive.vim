augroup GitSymbol
  autocmd!
  autocmd VimEnter,BufEnter,BufWritePost
        \,ColorScheme,ShellCmdPost,FocusGained
        \,TermChanged
        \ *
        \ call SyncGitStatusSymbolColor()
augroup END

" git status symbol
function! GitStatusSymbol()
  if !exists('b:git_dir')
    return ''
  endif
  return '⌁'
endfunction

" sync git status symbol color
function! SyncGitStatusSymbolColor()
  if !exists('b:git_dir')
    return
  endif
  let base_dir = b:git_dir[0 : len(b:git_dir)-5]
  let cmd = "cd ".base_dir." && git status -s --ignore-submodules=dirty"
  let git_dir_is_dirty = system(cmd)

  let is_reversed = synIDattr(synIDtrans(hlID('StatusLine')), 'reverse')
  if is_reversed
    let current_fg = synIDattr(synIDtrans(hlID('StatusLine')), 'bg')
    let current_bg = synIDattr(synIDtrans(hlID('StatusLine')), 'fg')
  else
    let current_fg = synIDattr(synIDtrans(hlID('StatusLine')), 'fg')
    let current_bg = synIDattr(synIDtrans(hlID('StatusLine')), 'bg')
  endif

  if empty(current_fg)
    let current_fg = 'NONE'
  endif

  if empty(current_bg)
    let current_bg = 'NONE'
  endif

  try
    if git_dir_is_dirty != ''
      exec 'hi User9 guifg=red guibg='.current_bg
      exec 'hi User9 ctermfg=red ctermbg='.current_bg
    else
      exec 'hi User9 guifg='.current_fg.' guibg='.current_bg
      exec 'hi User9 ctermfg='.current_fg.' ctermbg='.current_bg
    endif
  catch
    " we are doing this to avoid to determine if vim has true color support
  endtry
endfunction

call SyncGitStatusSymbolColor()
