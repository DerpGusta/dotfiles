vim.g.mapleader = ' '
vim.o.fcs = 'eob: ' -- for hiding the '~' in the end of the file buffer
vim.o.timeoutlen = 100
vim.o.guifont = 'FiraCode NF:h13'
vim.o.completeopt = 'menuone,noselect'
vim.o.number = true
vim.o.showmode = true
vim.o.mouse = "a"
--vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smartindent = true
-- vim.g.neovide_fullscreen = 'v:true'
-- vim.o.neovide_remember_window_size = 'v:true'
if vim.fn.has('wsl') then
vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf"
  },
  paste = {
    ["+"] = "win32yank.exe -o --crlf",
    ["*"] = "win32yank.exe -o --crlf"
  },
  cache_enable = 0,
}
end
