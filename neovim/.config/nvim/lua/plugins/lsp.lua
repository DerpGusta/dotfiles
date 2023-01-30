return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      --      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      --      'folke/neodev.nvim',
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {"williamboman/mason.nvim"},
    opts = {
      ensure_installed = {
        'ansiblels',
        'dockerls',
        'jsonls',
        'sumneko_lua',
        'pyright',
        'rust_analyzer',
        'terraformls',
      }
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          require("lspconfig")[server_name].setup { capabilities = capabilities}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        --["rust_analyzer"] = function ()
          --    require("rust-tools").setup {}
          --end
          ["sumneko_lua"] = function ()
            require("lspconfig")["sumneko_lua"].setup {
              settings = {
                Lua = {
                  diagnostics = {
                    globals = {"vim"}
                  }
                }
              }
            }
          end
        }
      end
    },
    {
      'williamboman/mason.nvim',
      --lazy = false, -- see https://github.com/williamboman/mason.nvim#setup
      --cmd = Mason,
      --keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
      opts = {
        ui = {
          border = "single",
        }
      },
      config = true
    },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      dependencies = {
        'williamboman/mason.nvim',
      },
      cmd = {'MasonToolsInstall','MasonToolsUpdate'},
      opts = {
        ensure_installed = {
          -- LSP Servers
          'ansible-language-server',
          'dockerfile-language-server',
          'lua-language-server',
          'python-lsp-server',
          'terraform-ls',
          'rust-analyzer',
          -- formatters, linters
          'rustfmt',
        },
        auto_update = true,
      }
    }
  }
