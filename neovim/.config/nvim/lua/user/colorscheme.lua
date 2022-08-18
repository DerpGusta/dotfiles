local colorscheme = "enfocado"
vim.o.background = "dark"
vim.g.enfocado_style = "nature"
require('lualine').setup { options = { theme = 'enfocado' } }

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
