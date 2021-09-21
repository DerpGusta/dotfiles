vim.g.nvim_tree_ignore = { ".git", "node_modules" }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_update_cwd = 1 
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_auto_ignore_ft = { "dashboard", "startify" }
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_lsp_diagnostics = 1
	      
local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
  if not status_ok then
    Log:get_default().error "Failed to load nvim-tree.config"
    return
  end

local tree_cb = nvim_tree_config.nvim_tree_callback

vim.g.nvim_tree_bindings = {
      { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
      { key = "h", cb = tree_cb "close_node" },
      { key = "r", cb = tree_cb "cd" },
      { key = "v", cb = tree_cb "vsplit" },
}
require("nvim-tree.events").on_nvim_tree_ready(function()
	vim.cmd("NvimTreeRefresh")
end)
