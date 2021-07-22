set spell
set spelllang=en_gb
" vimtex settings
let g:tex_flavor= 'latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method= 'zathura'
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
set conceallevel=0
