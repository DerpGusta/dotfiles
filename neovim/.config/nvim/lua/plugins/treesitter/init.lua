return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      highlight = { enable = true ,
      disable = {"latex"}},

      ensure_installed = {
        'lua',
        'terraform',
        'markdown',
        'markdown_inline',
        'html',
        'yaml',
        'vim',
        'vimdoc',
        'query',
        'dockerfile',
        'latex',
        'bibtex',
        'regex',
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>ss",
          node_incremental = "<leader>si",
          scope_incremental = "<leader>sc",
          node_decremental  = "<leader>sd",
        },
      },
    },
  },
}
