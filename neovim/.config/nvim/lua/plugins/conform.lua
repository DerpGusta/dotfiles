return {
  'stevearc/conform.nvim',
  event = { "BufRead" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = {"stylua"},
      terraform = {"tofu_fmt"},
      python = {"black"},
      bash = {"shfmt"},
      markdown = {"prettierd"},
      ["*"] = {"trim_whitespace"}  -- Run on all filetypes,
    },
    format_on_save = function(bufnr)
     if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 1500, lsp_fallback = true }
    end
  ,
    formatters = {
      terraform_fmt = {
      command = "tofu fmt"
      }
    }
  },

  config = function (_,opts)

    require("conform").setup(opts)

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})


  end
}
