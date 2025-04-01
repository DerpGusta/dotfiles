return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
    {
      mode = { "n", "v" },
      { "<leader>o", group = "obsidian" },
      { "<leader>sn", group = "noice" },
      { "<leader>t", group = "telescope" },
      { "<leader>x", group = "trouble" },
      { "<leader>z", group = "zen-mode" },
    },
    --   mode = { "n", "v"},
    --   ["<leader>t"] = { name = "+Telescope"},
    --   ["<leader>z"] = { name = "+Truezen"},
    --   ["<leader>o"] = { name = "+Obsidian"},
    --   ["<leader>x"] = { name = "+Trouble"},
    --  ["<leader>sn"] = { name = "+Noice" },
    }
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
  end
}
