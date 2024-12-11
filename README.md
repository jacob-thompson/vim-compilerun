# vim-compilerun

A plugin to quickly compile and run scripts from within Vim

## Install

Lazy.nvim

```lua
return { "jacob-thompson/vim-compilerun", name = "vim-compilerun" }
```

## Example Vim Configuration


The following maps the CompileRun function to `F5` in `Normal` and `Insert` mode:

```vimscript
map <F5> :CompileRun<CR>

imap <F5> <Esc>:CompileRun<CR>
```

## Example Neovim Configuration

The following maps the CompileRun function to `F5` in `Normal` and `Insert` mode:

```lua
vim.keymap.set("n", "<F5>", vim.cmd.CompileRun)

vim.keymap.set("i", "<F5>", function ()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", true)
    vim.cmd.CompileRun()
end)
```

## Usage

```vimscript
:CompileRun
```
