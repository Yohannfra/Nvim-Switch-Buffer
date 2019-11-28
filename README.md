# Nvim-Switch-Buffer

Nvim-Switch-Buffer is a plugin to quickly switch beetween open buffers in neovim.\
It uses the floating window feature of neovim

Example: \
![alt text](.github/gif.gif "Utilisation example")

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

Just add this line to your init.vim
```vim
" Feel free to map the shortcut you want
nnoremap S :SwitchBuffer <cr>
```