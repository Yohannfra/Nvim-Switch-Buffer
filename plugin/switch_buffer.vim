" vim plugin to go to switch beetween buffers
" Assouline Yohann
" November 2019

function! GetBufferList()
    let nb_buffers = bufnr("$")
    let all = range(1, nb_buffers)
    let buffers = []

    for i in all
        if buflisted(i)
            if len(bufname(i)) > 0
                call add(buffers, " [" . i . "] " . bufname(i))
            else
                call add(buffers, " [" . i . "] " ."[No Name]")
            endif
        endif
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
    echo s:buffers[index - 1]
endfunction

function! OpenFloatingWin()
    let opts = {'relative': 'editor',
                \ 'row': 0,
                \ 'col': (&columns / 2) - ((&columns / 2) / 2),
                \ 'width': &columns / 2,
                \ 'height': len(s:buffers)
                \}

    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)

    call nvim_buf_set_lines(buf, 0, -1, 0, s:buffers)

    setlocal buftype=nofile nobuflisted nomodifiable bufhidden=hide
                \ nonumber norelativenumber cursorline

    nnoremap <buffer> S :bd<cr>
    nnoremap <buffer> <cr> :call OpenBuffer('n') <cr>
    nnoremap <buffer> <space> :call OpenBuffer('n') <cr>
    nnoremap <buffer> v :call OpenBuffer('v') <cr>
    nnoremap <buffer> s :call OpenBuffer('s') <cr>
endfunction

function! SwitchBuffer()
    let s:buffers = GetBufferList()
    call OpenFloatingWin()
endfunction

command! SwitchBuffer execute SwitchBuffer()
