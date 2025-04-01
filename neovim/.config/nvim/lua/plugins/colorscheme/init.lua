return {
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
  {
    "Mofiqul/vscode.nvim",
    event = "VeryLazy",
    lazy = true,
    priority = 1000,
    config = function()
      require("vscode").setup()
      --   require("vscode").load()
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
    "miikanissi/modus-themes.nvim",
    event = "VeryLazy",
    lazy = true,
    priority = 10,
    config = function()
      require("modus-themes").setup({})
      -- vim.cmd([[colorscheme modus]])
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
    -- event = "VeryLazy",
    lazy = false,
    priority = 10,
    opts = { style = "night" },
    config = function(opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "sainnhe/gruvbox-material",
    event = "VeryLazy",
    lazy = true,
    priority = 100,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "original"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_disable_italic_comment = 1
      -- vim.cmd[[colorscheme gruvbox-material]]
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    event = "VeryLazy",
    lazy = true,
    priority = 10,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "https://github.com/therubymug/vim-pyte",
    priority = 100,
    lazy = true,
    config = function()
      -- vim.cmd[[colorscheme pyte]]
    end,
  },
  { "EdenEast/nightfox.nvim", lazy = false, event = "VeryLazy" },
}
