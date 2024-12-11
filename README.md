# CompileRun

A plugin to quickly compile and run scripts within Vim.

## Install

Lazy.nvim

```lua
return { "jacob-thompson/CompileRun.vim", name = "CompileRun" }
```

## Exaple Vim Configuration


The following maps the CompileRun function to `F5` in every mode:

```vimscript
map <F5> :call CompileRun#CompileRun()<CR>
imap <F5> <Esc>:call CompileRun#CompileRun()<CR>
vmap <F5> <Esc>:call CompileRun#CompileRun()<CR>
```

## Example Neovim Configuration

The following maps the CompileRun function to `F5` in every mode:

```lua
vim.keymap.set("n", "<F5>", vim.cmd.CompileRun)
vim.keymap.set("i", "<F5>", function ()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, false, true), 'n', true)
    vim.cmd.CompileRun()
end)
vim.keymap.set("v", "<F5>", function ()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, false, true), 'n', true)
    vim.cmd.CompileRun()
end)
```
