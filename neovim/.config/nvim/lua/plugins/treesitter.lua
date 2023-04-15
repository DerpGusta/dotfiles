return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  opts = {
    sync_install = false,
    auto_install = false,
    highlight = { enable = true, addtitional_vim_regex_highlighting = true },
    indent = { enable = false }, -- disabled since it is experimental as of now
    incremental_selection = { enable = true },
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
