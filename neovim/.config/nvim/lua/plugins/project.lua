return {
  "ahmedkhalf/project.nvim",
  dependencies = {"nvim-telescope/telescope.nvim"},
  config = function()
    require("project_nvim").setup {}
    require('telescope').load_extension('projects')
  end,
  keys = {
    { "<leader>ap", "<Cmd>Telescope projects<CR>", desc = "Projects" },
  },
}
