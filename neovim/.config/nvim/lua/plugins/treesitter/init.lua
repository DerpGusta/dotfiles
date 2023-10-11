return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  version = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    highlight = { enable = true },
    ensure_installed = {
      'lua',
      'terraform',
      'markdown',
      'markdown_inline',
      'html',
    }
  }
}
