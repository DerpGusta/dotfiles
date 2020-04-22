set number
let mapleader=','

set nocompatible
filetype plugin on
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

inoremap { {<CR>}<Esc>ko

nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>
call plug#begin()
Plug 'vimwiki/vimwiki'
Plug 'lifepillar/vim-solarized8'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
set t_Co=256   " This is may or may not needed.

set background=light
colorscheme solarized8_high
