return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {"williamboman/mason.nvim"},
		lazy = false,
		opts = {
			ensure_installed = {
				-- LSP Servers
				"ansible-language-server",
				"bash-language-server",
        "helm-ls",
				"lua-language-server",
				"marksman",
				"pyright",
				"terraform-ls",
				"yaml-language-server",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "gopls",
        "emmet_language_server",
        -- "ruby-lsp",
				-- formatters, linters
        "ansible-lint",
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
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
		keys = {
			{ "<leader>m", "<cmd>Mason<cr>", desc = "Open Mason" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        -- adapted from kickstart.nvim config
        group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
        callback = function(event)

          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a func is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["yamlls"] = function()
          require("lspconfig")["yamlls"].setup({
            capabilities = capabilities,
            settings = {
              yaml = {
                schemas = {
                  ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "*.argo.{yml,yaml}",
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
                  kubernetes = "/*.yaml",
                },
              -- format = { enabled = false },
              -- validate = false,
              completion = true,
              -- keyOrdering = false,
              },
            }
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
    end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim"},
		opts = {
			automatic_installation = true,
		},
		-- config = function(_, opts)
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- local on_attach = function(_, bufnr)
			-- 	local nmap = function(keys, cmd, desc)
			-- 		if desc then
			-- 			desc = "LSP: " .. desc
			-- 		end
			-- 		vim.keymap.set("n", keys, cmd, { buffer = bufnr, desc = desc })
			-- 	end
			-- 	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
			-- 	nmap("<leader>f", vim.lsp.buf.format, "Format buffer")
			-- 	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {desc= "LSP: Signature help"})
			-- end
			-- local lspopts = { capabilities = capabilities, on_attach = on_attach }
			-- require("mason-lspconfig").setup(opts)
			-- require("mason-lspconfig").setup_handlers({
			-- 	-- The first entry (without a key) will be the default handler
			-- 	-- and will be called for each installed server that doesn't have
			-- 	-- a dedicated handler.
			-- 	function(server_name) -- default handler (optional)
			-- 		require("lspconfig")[server_name].setup(lspopts)
			-- 	end,
			--
			-- 	-- Next, you can provide a dedicated handler for specific servers.
			-- 	-- For example, a handler override for the `rust_analyzer`:
			-- 	--["rust_analyzer"] = function ()
			-- 	--    require("rust-tools").setup {}
			-- 	--end
			-- 	["yamlls"] = function()
			-- 		require("lspconfig")["yamlls"].setup({
			-- 			schemaStore = {
			-- 				enable = true,
			-- 				url = "https://www.schemastore.org/api/json/catalog.json",
			-- 			},
			-- 			schemas = {
			-- 				kubernetes = "*.yaml",
			-- 				["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
			-- 				["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
			-- 				["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines.yml",
			-- 				["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
			-- 				["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
			-- 				["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
			-- 				["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
			-- 				["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
			-- 				["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
			-- 				["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
			-- 				["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
			-- 				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
			-- 				["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
			-- 			},
			-- 			format = { enabled = false },
			-- 			-- enabling this conflicts between Kubernetes resources and kustomization.yaml and Helmreleases
			-- 			-- see utils.custom_lsp_attach() for the workaround
			-- 			-- how can I detect Kubernetes ONLY yaml files? (no CRDs, Helmreleases, etc.)
			-- 			validate = false,
			-- 			completion = true,
			-- 			settings = {
			-- 				keyOrdering = false,
			-- 			},
			-- 			hover = true,
			-- 		})
			-- 	end,
			-- 	["lua_ls"] = function()
			-- 		require("lspconfig").lua_ls.setup({
			-- 			settings = {
			-- 				Lua = {
			-- 					runtime = {
			-- 						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
			-- 						version = "LuaJIT",
			-- 					},
			-- 					diagnostics = {
			-- 						-- Get the language server to recognize the `vim` global
			-- 						globals = { "vim" },
			-- 					},
			-- 					workspace = {
			-- 						-- Make the server aware of Neovim runtime files
			-- 						library = vim.api.nvim_get_runtime_file("", true),
			-- 					},
			-- 					-- Do not send telemetry data containing a randomized but unique identifier
			-- 					telemetry = {
			-- 						enable = false,
			-- 					},
			-- 				},
			-- 			},
			-- 		})
			-- 	end,
			-- })
		-- end,
	},
}
