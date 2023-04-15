return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  requires = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {"<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", desc = "files(cwd)"},
    {"<leader>fz", "<cmd>lua require('fzf-lua').builtin()<cr>", desc = "all fzf commands"},
    {"<leader>fd", "<cmd>lua require('fzf-lua').files({cwd=\"~/.config/nvim/lua/\"})<cr>", desc = "nvim dotfiles"},
  }
}
