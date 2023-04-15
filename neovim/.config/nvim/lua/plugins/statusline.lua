-- Set lualine as statusline
-- See `:help lualine.txt`
return  {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  opts = {
    options = {
      theme = "catppuccin",
      global_status = true,
      icons_enabled = true,
    --  component_separators = '|',
    --  section_separators = '',
      disabled_filetypes = {"neo-tree"},
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff','diagnostics'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = { 'lineno' },
        lualine_z = {}
      },
    }
  }
}
