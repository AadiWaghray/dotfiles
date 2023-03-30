"""""""""""""""""""
""Plug-In Imports""
"""""""""""""""""""
call plug#begin()
"Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
""Plug 'hrsh7th/nvim-cmp'
""Plug 'hrsh7th/cmp-buffer'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'sirver/ultisnips'
Plug 'lervag/vimtex'
Plug 'preservim/vim-pencil'

Plug 'romgrk/barbar.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

set termguicolors
set number
syntax enable
set wildmenu
set tabstop=4
set shiftwidth=4
set expandtab
set conceallevel=2
let g:vimtex_syntax_conceal_disable=1
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
tnoremap <Esc> <C-\><C-n>

""""""""""""""""""
"" UltiSnips """""
""""""""""""""""""
let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
let g:UltiSnipsJumpForwardTrigger  = '<Tab>'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'  " use Shift-Tab to move backward through tabstops

"""""""""""""""""""
"Color Scheme - nord
"""""""""""""""""""
colorscheme nord
