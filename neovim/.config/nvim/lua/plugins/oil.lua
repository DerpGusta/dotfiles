return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = false,
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    vim.keymap.set("n", "-", require("oil").open_float, { desc = "Open parent directory" })
  end,
}
