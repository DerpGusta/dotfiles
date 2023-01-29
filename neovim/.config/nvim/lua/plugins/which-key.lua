return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    key_labels = { ["<leader>"] = "SPC" },
    window = {
      border = "shadow",
    },
    icons = {
    separator = "->"
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end,
}
