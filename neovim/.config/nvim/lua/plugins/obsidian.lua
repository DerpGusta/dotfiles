return {
'epwalsh/obsidian.nvim',
dependencies = 'nvim-lua/plenary.nvim',
cmd = {"ObsidianNew","ObsidianQuickSwitch","ObsidianSearch"},
keys = {
  {"<leader>nn","<cmd>ObsidianNew<cr>", desc = "New Note"}
},
config = function()
  local path = "~/syncthing/common/wiki/"
  require('obsidian').setup({
      dir = path.."zettel",
      notes_subdir = "fleet-notes",
      daily_notes =  {
        folder = "diary"
      },
      completion = {
        nvim_cmp = true,
      },
  })
end
-- " (optional) for :ObsidianSearch and :ObsidianQuickSwitch commands unless you use telescope:
-- Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

-- " (optional) another alternative for the :ObsidianSearch and :ObsidianQuickSwitch commands:
-- Plug 'ibhagwan/fzf-lua'

-- " (optional) for :ObsidianSearch and :ObsidianQuickSwitch commands if you prefer this over fzf.vim:
-- Plug 'nvim-telescope/telescope.nvim'

-- " (optional) recommended for syntax highlighting, folding, etc if you're not using nvim-treesitter:
-- Plug 'preservim/vim-markdown'
-- Plug 'godlygeek/tabular'  " needed by 'preservim/vim-markdown'
--
-- " (required)

}
