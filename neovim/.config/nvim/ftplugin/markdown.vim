augroup TOC_on_write
    autocmd!
    autocmd TOC_on_write BufWritePost *.md silent WikiPageToc
    autocmd TOC_on_write BufWritePost *.md silent w
augroup END

