return {
  "monaqa/dial.nvim",
  event = "BufReadPre",
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.bool,
        augend.semver.alias.semver,
        augend.constant.new({ elements = { "let", "const" } }),
      },
    })
    vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
    vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
    vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
    vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
    vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
    vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
  end,
}
