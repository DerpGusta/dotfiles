return {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" , "Mofiqul/vscode.nvim"},
  opts = {
    theme = 'vscode',
    options = { section_separators = '', component_separators = '' },
    disabled_filetypes = {
      statusline = {'starter','quickfix','alpha'}
    },
    globalstatus = true,
    sections = {
      lualine_x = {'encoding', {'fileformat', symbols = {unix = ' '}}, 'filetype'},
      -- lualine_b = {'branch', {'diff',color = "Normal" }, 'diagnostics'},
      lualine_b = {'branch', {'diff',color = "Normal" }, 'diagnostics'},
    }
  }
}
