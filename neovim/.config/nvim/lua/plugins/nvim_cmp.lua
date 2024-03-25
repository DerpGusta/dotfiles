return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
  opts = function()
    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
    )
    return {
      completion = {
        -- autocomplete = false,
        keyword_length = 3,
        completeopt = "menu,menuone,noinsert,noselect",
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
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip", show_autosnippets = true },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
      },
      -- experimental = {
      --   ghost_text = {
      --     hl_group = "LspCodeLens",
      --   },
      -- },
    }
  end,
}
