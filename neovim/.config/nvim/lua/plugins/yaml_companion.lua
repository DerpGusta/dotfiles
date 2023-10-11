return {
	"someone-stole-my-name/yaml-companion.nvim",
  ft = "yaml",
	dependencies = {
		{ "neovim/nvim-lspconfig" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
	},
	config = function()
		local cfg = require("yaml-companion").setup({
			-- Add any options here, or leave empty to use the default settings
      schemas = {
        {
          name = "Kubernetes 1.28",
          uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28.0-standalone-strict/all.json"
        }
      },
			lspconfig = {
				settings = {
					format = { enable = false },
				},
			},
		})
		require("lspconfig")["yamlls"].setup(cfg)
		require("telescope").load_extension("yaml_schema")
	end,
}
