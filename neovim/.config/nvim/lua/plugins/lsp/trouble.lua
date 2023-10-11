return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>",                silent = true, noremap = true },
    {
      "<leader>xw",
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      silent = true,
      noremap = true,
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>xd",
      "<cmd>TroubleToggle document_diagnostics<cr>",
      silent = true,
      noremap = true,
      desc = "Document Diagnostics",
    },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",        silent = true, noremap = true },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",       silent = true, noremap = true, desc = "Quickfix list" },
    { "gR",         "<cmd>TroubleToggle lsp_references<cr>", silent = true, noremap = true, desc = "LSP References" },
  },
}
