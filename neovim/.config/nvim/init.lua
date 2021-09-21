-- ~/.config/nvim
--Load main config
--local modules = {
--	"options",
--	"mappings",
--	"plugins",
--	"theme"
--}
--
--for i = 1, #modules, 1 do
--	pcall(require, modules[i])
--end
vim.o.shadafile = 'NONE'
require('options')
require('mappings')
require('plugins')
require('theme')
vim.o.shadafile = ''

--vim.cmd('cd /mnt/c/Users/SriHarshaTolety/Desktop/')
