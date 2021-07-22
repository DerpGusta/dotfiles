if exists('g:vscode')
    " VSCode extension
else
"Install vim-plug if not existing
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC | q
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'srcery-colors/srcery-vim'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'https://github.com/alok/notational-fzf-vim'
Plug 'dstein64/vim-startuptime'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
"Plug 'neovim/nvim-lspconfig'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim',
Plug 'godlygeek/tabular'
call plug#end()
"my mappings
let mapleader =" "
let maplocalleader =" "
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <C-l> :<C-u>noh<CR><C-l> 
tnoremap <Esc> <C-\><C-n>

set termguicolors " muh colors...
syntax enable
set number        "number line on the left
set noshowmode    "Because of lightline,we don't need to show mode again!
set mouse=a
set timeoutlen=500
set hidden
set cursorline
set title
set incsearch

colorscheme srcery
"hi Normal guibg=NONE ctermbg=NONE "for transparency 
" tabs
set tabstop=4     "number of spaces a tab renders as
set expandtab     "convert tabs to spaces automatically.(Tabs ftw!)
set shiftwidth=4  "number of spaces to use for auto-indentation

"==================== plugin: lightline ====================
let g:lightline = {
            \ 'colorscheme': 'srcery'
    \}
"==================== plugin: nvim-lspconfig ====================
"lua << EOF
"require 'lspconfig'.pyright.setup{}
"EOF
"==================== plugin: COC ====================
let g:coc_global_extensions = [
            \ 'coc-vimtex',
            \ 'coc-marketplace',
            \ 'coc-pyright',
            \ 'coc-snippets',
            \ 'coc-emmet',
            \ 'coc-pairs',
            \]
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr><cr>    pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
inoremap <expr><tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
imap <silent> <c-u>      <plug>(coc-snippets-expand-jump)

" =================== plugin: Ultisnips ====================
let g:UltiSnipsExpandTrigger = '<nop>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsRemoveSelectModeMappings = 0

" =================== plugin: FZF ====================
nnoremap <C-p> :<C-u>Files<CR>

" =================== plugin: Emmet ====================
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" =================== plugin: vimwiki ====================
let g:vimwiki_global_ext = 0

" =================== plugin: notational-fzf ====================
let g:nv_search_paths = ['~/notes/notes','~/vimwiki']
nnoremap <silent> <c-s> :NV<CR>
" =================== plugin: WhichKey ==================== 
nnoremap <silent><leader> :WhichKey '<Space>'<CR>
endif
