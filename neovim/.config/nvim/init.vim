"Install vim-plug if not existing
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC | q
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
set termguicolors " muh colors...
syntax enable
set number        "number line on the left
set noshowmode    "Because of airline,we don't need to show mode again!
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
colorscheme gruvbox
" tabs
set tabstop=4     "number of spaces a tab renders as
set expandtab     "convert tabs to spaces automatically.(Tabs ftw!)
set shiftwidth=4  "number of spaces to use for auto-indentation

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:UltiSnipsExpandTrigger="<tab>"  " use <Tab> to trigger autocompletion
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" markdown-preview keybinding(s)
nnoremap <M-m> :MarkdownPreview<CR>
