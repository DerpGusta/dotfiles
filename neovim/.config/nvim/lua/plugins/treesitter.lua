return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  opts = {
    sync_install = false,
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = false }, -- disabled since it is experimental as of now
    ensure_installed = {
      "bash",
      "help",
      "html",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "vim",
      "yaml",
      "terraform"
    },
  },
  config = function(plugin, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
