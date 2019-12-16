" vim plugin to go to switch beetween buffers
" Assouline Yohann
" November 2019

if exists('g:switch_buffer_loadded') || !has("nvim")
    finish
endif

let g:switch_buffer_loadded = 1

let g:switch_buffer_shortcuts = {
\    "S" : ":bd",
\    "<esc>" : ":bd",
\    "<cr>" : ":call OpenBuffer('n')",
\    "<space>" : ":call OpenBuffer('n')",
\    "v" : ":call OpenBuffer('v')",
\    "s" : ":call OpenBuffer('s')",
\    "dd" : ":call CloseBuffer()"
\}

command! SwitchBuffer :call switch_buffer#SwitchBuffer()
