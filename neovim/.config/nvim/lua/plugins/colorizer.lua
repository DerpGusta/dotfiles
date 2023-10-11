return {
  'NvChad/nvim-colorizer.lua',
  cmd = "ColorizerToggle",
  config = function()
    require 'colorizer'.setup()
  end,
}
