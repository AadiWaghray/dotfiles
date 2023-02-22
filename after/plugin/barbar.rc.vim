" Move to previous/next
nnoremap <silent>    z, <Cmd>BufferPrevious<CR>
nnoremap <silent>    z. <Cmd>BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    z< <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    z> <Cmd>BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    z1 <Cmd>BufferGoto 1<CR>
nnoremap <silent>    z2 <Cmd>BufferGoto 2<CR>
nnoremap <silent>    z3 <Cmd>BufferGoto 3<CR>
nnoremap <silent>    z4 <Cmd>BufferGoto 4<CR>
nnoremap <silent>    z5 <Cmd>BufferGoto 5<CR>
nnoremap <silent>    z6 <Cmd>BufferGoto 6<CR>
nnoremap <silent>    z7 <Cmd>BufferGoto 7<CR>
nnoremap <silent>    z8 <Cmd>BufferGoto 8<CR>
nnoremap <silent>    z9 <Cmd>BufferGoto 9<CR>
nnoremap <silent>    z0 <Cmd>BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    zp <Cmd>BufferPin<CR>
" Close buffer
nnoremap <silent>    zc <Cmd>BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout
" Close commands
"                          :BufferCloseAllButCurrent
"                          :BufferCloseAllButVisible
"                          :BufferCloseAllButPinned
"                          :BufferCloseAllButCurrentOrPinned
"                          :BufferCloseBuffersLeft
"                          :BufferCloseBuffersRight
" Magic buffer-picking mode
nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used

