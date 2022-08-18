local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_augroup('packer_autosource',{clear = true})
vim.api.nvim_create_autocmd({'BufWritePost'},{pattern = {"plugins.lua"},command = ":source <afile> | PackerSync"})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

local packer = require('packer')

packer.init({
  profile = {
    enable = true,
    threshold = 1
  },
  autoremove = true
})
packer.reset()
return packer.startup(function(use)
  use "wbthomason/packer.nvim"
--  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
--  use "windwp/nvim-autopairs"
--  use "numToStr/Comment.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
--  use "akinsho/bufferline.nvim"
--  use "akinsho/toggleterm.nvim"
--  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
--  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
--  use "lukas-reineke/indent-blankline.nvim"
--  use "christianchiarulli/hop.nvim"
  -- use "phaazon/hop.nvim"
  -- Mini.nvim
  use { 
    "echasnovski/mini.nvim",
    branch = "stable"
  }
  -- Lua
  use "kylechui/nvim-surround"
  -- Lua
--  use {
--    "abecodes/tabout.nvim",
--    wants = { "nvim-treesitter" }, -- or require if not used so far
--  }

  -- Colorschemes
  use "folke/tokyonight.nvim"
  use "wuelnerdotexe/vim-enfocado"


  -- cmp plugins
  use { "hrsh7th/nvim-cmp" }
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "RRethy/vim-illuminate"

  -- Rust
 -- use "simrat39/rust-tools.nvim"
 -- use "Saecki/crates.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }
  use "windwp/nvim-ts-autotag"

  -- Git
--  use "lewis6991/gitsigns.nvim"

  -- DAP
--  use "mfussenegger/nvim-dap"
--  use "rcarriga/nvim-dap-ui"
--  use "Pocco81/DAPInstall.nvim"

  -- Plugin Graveyard
  -- use "romgrk/nvim-treesitter-context"
  -- use "mizlan/iswap.nvim"
  -- use {'christianchiarulli/nvim-ts-rainbow'}
  -- use "nvim-telescope/telescope-file-browser.nvim"
  -- use 'David-Kunz/cmp-npm' -- doesn't seem to work
  -- use { "christianchiarulli/JABS.nvim" }
  -- use "lunarvim/vim-solidity"
  -- use "tpope/vim-repeat"
  -- use "Shatur/neovim-session-manager"
  -- use "metakirby5/codi.vim"
  -- use { "nyngwang/NeoZoom.lua", branch = "neo-zoom-original" }
  -- use "rcarriga/cmp-dap"
  -- use "filipdutescu/renamer.nvim"
  -- use "https://github.com/rhysd/conflict-marker.vim"
  -- use "rebelot/kanagawa.nvim"
  -- use "unblevable/quick-scope"
  -- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for 
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
