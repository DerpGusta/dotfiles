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
call plug#end()
set termguicolors " muh colors...
syntax enable
"set background=dark
set number        "number line on the left
set autoindent    "directly follow the previous line indentation
set noshowmode " Because of airline,we don't need to show mode again!
set backspace=indent,eol,start
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
colorscheme gruvbox
" tabs
set tabstop=4     "number of spaces a tab renders as
set expandtab     "convert tabs to spaces automatically.(Tabs ftw!)
set shiftwidth=4  "number of spaces to use for auto-indentation
set smarttab      "helps with backspacing because of expandtab
