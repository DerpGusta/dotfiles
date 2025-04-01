return {{
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "yutkat/cmp-mocword",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
    )
    cmp.setup {
      completion = {
        autocomplete = false,
        keyword_length = 3,
        -- completeopt = "menu,menuone,noinsert,noselect",
      },
      matching = {
        disallow_fullfuzzy_matching = true,
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-d>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip", show_autosnippets = true },
        { name = "mocword" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
      },
      experimental = {
          ghost_text = {
              hl_group = "LspCodeLens",
            },
          },
        }
        cmp.setup.filetype("tex", {
          sources = {
            { name = 'vimtex' },
            { name = 'buffer' },
            -- other sources
          },
        })
      end,
    },
    {
      "micangl/cmp-vimtex",
      config = function()
        require('cmp_vimtex').setup({
          additional_information = {
            info_in_menu = true,
            info_in_window = true,
            info_max_length = 60,
            match_against_info = true,
            symbols_in_menu = true,
          },
          bibtex_parser = {
            enabled = true,
          },
          search = {
            browser = "xdg-open",
            default = "google_scholar",
            search_engines = {
              google_scholar = {
                name = "Google Scholar",
                get_url = require('cmp_vimtex').url_default_format("https://scholar.google.com/scholar?hl=en&q=%s"),
              },
              -- Other search engines.
            },
          },
        })
      end,
    }
  }
