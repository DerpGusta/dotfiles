return {{
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  opts = function()
    local null_ls = require("null-ls")
    return {
      sources = {
        null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.code_actions.shellcheck,
      } }
    end
  },
  }
