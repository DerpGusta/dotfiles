set spell
set spelllang=en_gb
noremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
imap <silent><c-u> <plug>(coc-snippets-expand)
" vimtex settings
let g:tex_flavor= 'latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method= 'zathura'
set conceallevel=1
