" vim plugin to go to switch beetween buffers
" Assouline Yohann
" November 2019

function! GetBufferList()
    let buffer_list = nvim_list_bufs()
    let s:current_buffer = nvim_get_current_buf()
    let buffers = []
    let index = 0

    for i in buffer_list
        if buflisted(i)
            if len(bufname(i)) > 0
                call add(buffers, " [" . i . "] " . bufname(i))
            else
                call add(buffers, " [" . i . "] " ."[No Name]")
            endif
            if i == s:current_buffer
                let buffers[index] = buffers[index] . '  <=='
            endif
        endif
        let index += 1
    endfor
    return buffers
endfunction

function! OpenBuffer(pos)
    let index = getpos('.')[1]
    let f = split(s:buffers[index - 1])
    let f = f[0][1 : index(f, ']') - 1]

    execute ":q"
    if a:pos ==# 'n'
        execute ":b " . f
    elseif a:pos ==# 'v'
        execute ":vertical sb " . f
    elseif a:pos ==# 's'
        execute ":sb " . f
    endif
endfunction

function! OpenFloatingWin()
    let y = len(s:buffers)
    while y % 5 != 0
        let y = y + 1
    endwhile
    let opts = {'relative': 'editor',
                \ 'row': 0,
                \ 'col': (&columns / 2) - ((&columns / 2) / 2),
                \ 'width': &columns / 2,
                \ 'height': y
                \}

    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)
    call nvim_buf_set_lines(buf, 0, -1, 0, s:buffers)

    setlocal buftype=nofile nobuflisted nomodifiable bufhidden=hide
                \ nonumber cursorline cc=0

    for i in range(10)
        execute 'nnoremap <buffer>' . i . ' :'i . '<cr>'
    endfor
    execute ":" . s:current_buffer
    nnoremap <buffer> S :bd<cr>
    nnoremap <buffer> <esc> :q <cr>
    nnoremap <buffer> <cr> :call OpenBuffer('n') <cr>
    nnoremap <buffer> <space> :call OpenBuffer('n') <cr>
    nnoremap <buffer> v :call OpenBuffer('v') <cr>
    nnoremap <buffer> s :call OpenBuffer('s') <cr>
endfunction

function! SwitchBuffer()
    if bufnr("$") == 1
        echo "You only have this buffer"
        return
    endif
    let s:buffers = GetBufferList()
    call OpenFloatingWin()
endfunction

command! SwitchBuffer :call SwitchBuffer()
