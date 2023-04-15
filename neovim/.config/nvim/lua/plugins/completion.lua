return {
  {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require('cmp')
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      return {
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            --maxwidth = 50,
            --         menu = {
              --           buffer = "[buf]",
              --           calc = "[calc]",
              --           emoji = "[emoji]",
              --           fish = "[fish]",
              --           look = "[look]",
              --           luasnip = "[snip]",
              --           nvim_lsp = "[lsp]",
              --           nvim_lua = "[lua]",
              --           path = "[path]",
              --         },
            }),
          },
          experimental = { ghost_text = true},
          singlewindow = {
            completion = {
              border = "single"
            },
            documentation = {
              border = "single"
            }
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-j>'] = cmp.mapping(function(fallback)
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, {"i", "s"}),
            ['<C-k>'] = cmp.mapping(function(fallback)
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, {"i", "s"}),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-y>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
                -- they way you will only jump inside the snippet region
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'luasnip' },
          }),
          -- Set configuration for specific filetype

          -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
          cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = 'buffer' }
            }
          }),

          -- Use cmdline & path source for ':' (if you enabled `native_menu`, this on't ork anymore).
          cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = 'path' }
            }, {
              { name = 'cmdline' }
            })
          }),
        }
      end
    },

    {
      "windwp/nvim-autopairs",
      dependencies = {
        "hrsh7th/nvim-cmp",
      },
      event = "VeryLazy",
      config = function()
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        require("nvim-autopairs").setup({
          check_ts = true,
        })
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end

    },

    {
      'L3MON4D3/LuaSnip',
      version = 'v1.2.x',
      event = "InsertEnter",
      dependencies = {'rafamadriz/friendly-snippets'},
      config = function (_,_)
        require('luasnip').setup({
          history = true,
          delete_check_events = "TextChanged"
        })
        require("luasnip.loaders.from_vscode").lazy_load()
      end
    },

  }
