return {
  "OXY2DEV/markview.nvim",
  lazy = false, -- Recommended
  config = function()
    require("markview").setup({
      preview = {
        enable = true,
        hybrid_modes = { "n" },
      },
    })
  end,
}
