# vim-compilerun

Compile and run scripts from within Vim

## Install

[Vundle.vim](https://github.com/gmarik/Vundle.vim):

```vimscript
Plugin 'jacob-thompson/vim-compilerun'
```

[vim-plug](https://github.com/junegunn/vim-plug):

```vimscript
Plug 'jacob-thompson/vim-compilerun'
```

[vim-pathogen](https://github.com/tpope/vim-pathogen):

```bash
git clone https://github.com/jacob-thompson/vim-compilerun.git ~/.vim/bundle/vim-compilerun
```

[Lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return { "jacob-thompson/vim-compilerun", name = "vim-compilerun" }
```

## Example Vim Configuration


The following vimscript code maps CompileRun to `F5` in the `Normal`, `Insert`, and `Visual` modes:

```vimscript
map <F5> <Cmd>CompileRun<CR>
imap <F5> <Esc><Cmd>CompileRun<CR>
vmap <F5> <Esc><Cmd>CompileRun<CR>
```

## Example Neovim Configuration

The following lua code maps CompileRun to `F5` in the `Normal`, `Insert`, and `Visual` modes:

```lua
vim.keymap.set("n", "<F5>", "<Cmd>CompileRun<CR>")
vim.keymap.set("i", "<F5>", "<Esc><Cmd>CompileRun<CR>")
vim.keymap.set("v", "<F5>", "<Esc><Cmd>CompileRun<CR>")
```

## Usage

```vimscript
:CompileRun
```
