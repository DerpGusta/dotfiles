return {
  {
    "Mofiqul/vscode.nvim",
    event = "VeryLazy",
    lazy = true,
    priority = 1000,
    config = function()
      require("vscode").setup()
      require("vscode").load()
    end,
  },
  {
    "maxmx03/solarized.nvim",
    lazy = true,
    priority = 100,
    config = function()
      local success, solarized = pcall(require, "solarized")
      if not success then
        print("solarized.nvim not installed!")
      end
      solarized.setup({
        theme = "default",
        transparent = false,
        colors = function(colors, colorhelper)
          local darken = colorhelper.darken
          local lighten = colorhelper.lighten
          local blend = colorhelper.blend
          return {}
        end,
        highlights = function(colors, darken, lighten, blend)
          return {
            MiniIndentscopeSymbol = { fg = colors.blue },
          }
        end,
      })
    end,
  },
  {
    "ribru17/bamboo.nvim",
    event = "VeryLazy",
    lazy = true,
    priority = 100,
    config = function()
      require("bamboo").setup({})
      -- require("bamboo").load()
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "VeryLazy",
    lazy = true,
    priority = 100,
    config = function()
      require("catppuccin").setup({
        flavour = "latte", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
      },
      })
      -- vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    event = "VeryLazy",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    priority = 10, -- make sure to load this after NeoSolarized to not override
    config = function()
      require("github-theme").setup({})
    end,
  },
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
    lazy = true,
    priority = 100,
    opts = {},
  },
  {
    "ellisonleao/gruvbox.nvim",
    event = "VeryLazy",
    lazy = true,
    priority = 100,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
      })
      -- vim.cmd[[colorscheme gruvbox]]
    end,
  },
  { "EdenEast/nightfox.nvim", lazy = false, event = "VeryLazy" },
}
