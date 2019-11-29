" vim plugin to go to switch beetween buffers
" Assouline Yohann
" November 2019

let g:switch_buffer_shortcuts = {
\    "S" : ":bd",
\    "<esc>" : ":bd",
\    "<cr>" : ":call OpenBuffer('n')",
\    "<space>" : ":call OpenBuffer('n')",
\    "v" : ":call OpenBuffer('v')",
\    "s" : ":call OpenBuffer('s')",
\    "dd" : "call CloseBuffer()"
\}

function! GetBufferList()
    let buffer_list = nvim_list_bufs()
    let s:buffers = {}

    for buf in buffer_list
        if buflisted(buf)
            if len(bufname(buf)) > 0
                let s:buffers[buf] = bufname(buf)
            else
                let s:buffers[buf]= "[No Name]"
            endif
        endif
    endfor
endfunction

function! OpenBuffer(pos)
    let index = keys(s:buffers)[getpos('.')[1] - 1]

    execute ":q"
    if a:pos ==# 'n'
        execute ":b " . index
    elseif a:pos ==# 'v'
        execute ":vertical sb " . index
    elseif a:pos ==# 's'
        execute ":sb " . index
    endif
endfunction

function! CloseBuffer()
    let index = keys(s:buffers)[getpos('.')[1] - 1]

    if len(s:buffers) > 1 && index != s:current_buffer
        execute ":bd " . index . " | :q | :call SwitchBuffer()"
    else
        echo "You can't close your last or actual buffer"
    endif
endfunction

function! OpenFloatingWin()
    let len_buf = len(s:buffers)
    let opts = {'relative': 'editor',
                \ 'row': 0,
                \ 'col': (&columns / 2) - ((&columns / 2) / 2),
                \ 'width': &columns / 2,
                \ 'height': len_buf > 2 ? len_buf : len_buf + 1
                \}

    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)

    let i = 1
    for key in keys(s:buffers)
        if key == s:current_buffer
            call setbufline(buf, i, "[" . key . "]  " .
                        \s:buffers[key] . "\t\t<==")
        else
            call setbufline(buf, i, "[" . key . "]  " . s:buffers[key])
        endif
        let i += 1
     endfor

     setlocal buftype=nofile nobuflisted nomodifiable bufhidden=hide
                \ nonumber cursorline cc=0

    execute ":" . (index(keys(s:buffers), "" . s:current_buffer) + 1)

    for i in keys(g:switch_buffer_shortcuts)
        execute 'nnoremap <buffer>' . i . ' ' .
                    \g:switch_buffer_shortcuts[i] . "<cr>"
    endfor
endfunction

function! SwitchBuffer()
    if bufnr("$") == 1
        echo "You only have this buffer"
        return
    endif

    let s:current_buffer = nvim_get_current_buf()
    call GetBufferList()
    call OpenFloatingWin()
endfunction

command! SwitchBuffer :call SwitchBuffer()
