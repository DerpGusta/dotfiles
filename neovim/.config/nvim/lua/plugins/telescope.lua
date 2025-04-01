return {
	{
		"nvim-telescope/telescope.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		opts = {
			defaults = {
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
			extensions = {
				terraform_doc = {
					url_open_command = "xdg-open",
				},
			},
		},
		keys = {
			{ "<leader>f", "<cmd>Telescope find_files theme=dropdown<cr>", desc = "Find Files" },
			{ "<leader>to", "<cmd>Telescope oldfiles<cr>", desc = "Old Files" },
			{ "<leader>tc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
			{ "<leader>tt", "<cmd>Telescope <cr>", desc = "Builtins" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>ty", "<cmd>Telescope yaml_schema<cr>", desc = "Yaml Schema" },
			-- { "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP Symbols" },
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").load_extension("file_browser")
		end,
		keys = {
			{
				"<leader>td",
				function()
					return require("telescope").extensions.file_browser.file_browser({
						cwd = "~/.config/nvim/lua/plugins/",
					})
				end,
				desc = "Dotfiles",
			},
		},
	},
	{
		"ANGkeith/telescope-terraform-doc.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("terraform_doc")
		end,
		keys = {
			{ "<leader>tp", "<cmd>Telescope terraform_doc<cr>", desc = "TF:Providers " },
			{ "<leader>tm", "<cmd>Telescope terraform_doc modules<cr>", desc = "TF:Modules" },
			{ "<leader>ta", "<cmd>Telescope terraform_doc full_name=hashicorp/aws<cr>", desc = "TF:AWS" },
			{
				"<leader>tz",
				"<cmd>Telescope terraform_doc full_name=hashicorp/azurerm<cr>",
				desc = "TF:Azure",
			},
			{
				"<leader>tk",
				"<cmd>Telescope terraform_doc full_name=hashicorp/kubernetes<cr>",
				desc = "TF:Kubernetes",
			},
		},
	},
}
