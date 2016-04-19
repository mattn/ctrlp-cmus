if ( exists('g:loaded_ctrlp_cmus') && g:loaded_ctrlp_cmus ) || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_cmus = 1

call add(g:ctrlp_ext_vars, {
  \ 'init': 'ctrlp#cmus#init()',
  \ 'accept': 'ctrlp#cmus#accept',
  \ 'lname': 'cmus',
  \ 'sname': 'cmus',
  \ 'type': 'line',
  \ 'specinput': 0,
  \ })

function! ctrlp#cmus#init()
  if (!exists('s:list'))
    let s:list = systemlist('cmus-remote -C "save -l -"')
  endif
  return s:list
endfunction

function! ctrlp#cmus#accept(mode, str)
  call system('cmus-remote -C ' . shellescape('player-play ' . a:str))
endfunction

let s:artist_id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#cmus#id()
  return s:artist_id
endfunction

function! ctrlp#cmus#clear_cache()
  if (exists('g:artists'))
    unlet g:artists
  endif
endfunction

" vim:set et:
