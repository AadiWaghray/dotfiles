let g:pencil#textwidth = 70
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
    autocmd!
    autocmd FileType markdown,mkd,tex call pencil#init()
    autocmd FileType text         call pencil#init({'wrap': 'hard'})
augroup END
set statusline=%<%f\ %h%m%r%w\ \ %{PencilMode()}\ %=\ col\ %c%V\ \ line\ %l\,%L\ %P
set rulerformat=%-12.(%l,%c%V%)%{PencilMode()}\ %P
