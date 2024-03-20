set nopaste

" Use ALE's function for omnicompletion.
set omnifunc=ale#completion#OmniFunc

let g:ale_completion_enabled = 1
function! SmartInsertCompletion() abort
    " Use the default CTRL-N in completion menus
    if pumvisible()
      return "\<C-n>"
    endif

    " Exit and re-enter insert mode, and use insert completion
    return "\<C-c>a\<C-n>"
endfunction

inoremap <silent> <C-n> <C-R>=SmartInsertCompletion()<CR>


