return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				-- LSP Servers
				"ansible-language-server",
				"bash-language-server",
        "helm_ls",
				"lua-language-server",
				"marksman",
				"pyright",
				"terraform-ls",
				"yaml-language-server",
        "gopls",
				-- formatters, linters
				"black",
				"prettierd",
				"shellcheck",
				"shfmt",
				"stylua",
				"tflint",
			},
			auto_update = true,
			run_on_start = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
		keys = {
			{ "<leader>m", "<cmd>Mason<cr>", desc = "Open Mason" },
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			automatic_installation = true,
		},
		config = function(_, opts)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(_, bufnr)
				local nmap = function(keys, cmd, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, cmd, { buffer = bufnr, desc = desc })
				end
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<leader>f", vim.lsp.buf.format, "Format buffer")
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature help")
			end
			local lspopts = { capabilities = capabilities, on_attach = on_attach }
			require("mason-lspconfig").setup(opts)
			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup(lspopts)
				end,

				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				--["rust_analyzer"] = function ()
				--    require("rust-tools").setup {}
				--end
				["yamlls"] = function()
					require("lspconfig")["yamlls"].setup({
						schemaStore = {
							enable = true,
							url = "https://www.schemastore.org/api/json/catalog.json",
						},
						schemas = {
							kubernetes = "*.yaml",
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines.yml",
							["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
							["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
							["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
							["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
							["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
							["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
							["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
							["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
							["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
						},
						format = { enabled = false },
						-- enabling this conflicts between Kubernetes resources and kustomization.yaml and Helmreleases
						-- see utils.custom_lsp_attach() for the workaround
						-- how can I detect Kubernetes ONLY yaml files? (no CRDs, Helmreleases, etc.)
						validate = false,
						completion = true,
						settings = {
							keyOrdering = false,
						},
						hover = true,
					})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								runtime = {
									-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
									version = "LuaJIT",
								},
								diagnostics = {
									-- Get the language server to recognize the `vim` global
									globals = { "vim" },
								},
								workspace = {
									-- Make the server aware of Neovim runtime files
									library = vim.api.nvim_get_runtime_file("", true),
								},
								-- Do not send telemetry data containing a randomized but unique identifier
								telemetry = {
									enable = false,
								},
							},
						},
					})
				end,
			})
		end,
	},
}
