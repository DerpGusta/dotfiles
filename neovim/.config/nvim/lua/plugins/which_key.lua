return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    defaults = {
      mode = { "n", "v"},
      ["<leader>t"] = { name = "+Telescope"},
      ["<leader>z"] = { name = "+Truezen"},
      ["<leader>o"] = { name = "+Obsidian"},
      ["<leader>x"] = { name = "+Trouble"},
    }
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end
}
