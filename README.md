# Nvim-Switch-Buffer

Nvim-Switch-Buffer is a plugin to quickly switch between open buffers in neovim.\
It uses the floating window feature of neovim

Example: \
![alt text](.github/demo.gif "Utilisation example")

## Installation

### Using Plug
```
Plug 'Yohannfra/Nvim-Switch-Buffer'
```

### Manual installation
```
git clone https://github.com/Yohannfra/Nvim-Switch-Buffer/ ~/.vim/plugin/
```

## Configuration

Just add these lines to your init.vim
```vim
" Feel free to map the shortcut you want
nnoremap S :SwitchBuffer <cr>

set switchbuf=usetab
```

You can also hide the buffer numbers with
```
    let g:switch_buffer_hide_numbers = 1
```

## How to use

- Navigate in the window using j/k or Up/Down
- Press Enter or Space to open the buffer
- Press s to open the buffer in a horizontal split
- Press v to open the buffer in a vertical split
- Press t to open the buffer in a new tab
- Press S or :q to close the window

## License

This project is licensed under the terms of the MIT license.
