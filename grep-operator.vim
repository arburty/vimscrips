" grep-operator.vim
" Author : Austin Burt
" Email  : austin@burt.us.com
" Date   : 06/01/20
"
" Made by following along with 'Learn Vimscript the Hard Way' chapters 32-34
" https://learnvimscriptthehardway.stevelosh.com/chapters/33.html

echom "grep-operator"
nnoremap <leader>G :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>G :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[y`]"
    else
        return
    endif

    silent execute "grep! -r -I " . shellescape(@@) . " ."
    redraw!
    copen

    let @@ = saved_unnamed_register
endfunction
