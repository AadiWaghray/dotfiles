runtime! ./init/*.vim

"""""""""""""""""""
"Color Scheme - nord
"""""""""""""""""""
colorscheme nord

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
tnoremap <Esc> <C-\><C-n>

"""""""""""""""""""
"Utili Snips """"""
"""""""""""""""""""
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=['UltiSnips']
