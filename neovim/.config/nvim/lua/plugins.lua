local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- local present, _ = pcall(require, "packerinit")
-- local packer

-- if present then
--     packer = require "packer"
-- else
--     return false
-- end

return require("packer").startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {
        "nvim-telescope/telescope.nvim",
        config = function()
            require('config.telescope')
        end,
        cmd = { "Telescope" },
        module = "telescope",
        wants = {
            "plenary.nvim",
            "popup.nvim",
            "telescope-z.nvim",
            -- "telescope-frecency.nvim",
            "telescope-fzy-native.nvim",
            "telescope-project.nvim",
            "telescope-symbols.nvim",
        },
        requires = {
            {"nvim-telescope/telescope-z.nvim", opt=true},
            {"nvim-telescope/telescope-project.nvim", opt=true},
            {"nvim-lua/popup.nvim", opt=true},
            {"nvim-lua/plenary.nvim", opt=true},
            {"nvim-telescope/telescope-symbols.nvim", opt=true},
            {"nvim-telescope/telescope-fzy-native.nvim", opt=true},
        },
    }
    use{
        "hoob3rt/lualine.nvim",
        event = "VimEnter",
        config = function() require('config.lualine') end,
        wants = "nvim-web-devicons",
    }
    use {'neovim/nvim-lspconfig', requires = {}}
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('config.nvim-cmp') end,
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/vim-vsnip'},
        }
    }
    use {
        'hrsh7th/cmp-vsnip',
        after = 'nvim-cmp',
        requires = {
            'hrsh7th/vim-vsnip',
            {
                'rafamadriz/friendly-snippets',
                after = 'cmp-vsnip'
            }
        }
    }
    use {'rafamadriz/friendly-snippets'}
    use {'williamboman/nvim-lsp-installer', config = function()
        require('config.lspinstall') end,
        requires = {'neovim/nvim-lspconfig'}
    }
    use {'kyazdani42/nvim-web-devicons'} -- for file icons
    use {'lukas-reineke/indent-blankline.nvim', config = function() require('config.indent-blankline') end }
    use {'kyazdani42/nvim-tree.lua', cmd = "NvimTreeToggle",config = function() require "config.nvimtree" end } -- file explorer
    use {'windwp/nvim-autopairs', config = function() require "config.autopairs" end}
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        opt = true,
        event = "BufRead",
        requires = {
            { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
            "nvim-treesitter/nvim-treesitter-textobjects",
            "RRethy/nvim-treesitter-textsubjects",
        },
        config = [[require('config.treesitter')]],
    })
    use {'karb94/neoscroll.nvim', config = function() require('config.neoscroll') end }
    use {'NLKNguyen/papercolor-theme'}
    use {'lervag/wiki.vim',config= function() require"config.wiki" end }
    use {'plasticboy/vim-markdown',config=function() require('config.vim-markdown') end, ft = {'markdown'} }
    -- use {'ishan9299/modus-theme-vim'}
    use {'junegunn/vim-easy-align'}
    use {'kevinhwang91/rnvimr', cmd = 'RnvimrToggle'}
    use {'tpope/vim-surround'}
    use {'tpope/vim-commentary'}
    use {'tpope/vim-repeat'}
    use {'hashivim/vim-terraform', ft = {'terraform'}}
    use {'ellisonleao/glow.nvim', cmd = 'Glow'}
    use {'folke/which-key.nvim', event = "BufWinEnter",config = function() require "config.which-key" end }
    -- Theme: color schemes
    -- use("tjdevries/colorbuddy.vim")
    use{'rktjmp/lush.nvim'}
    use({
        "shaunsingh/nord.nvim",
        "shaunsingh/moonlight.nvim",
        -- { "olimorris/onedark.nvim", requires = "rktjmp/lush.nvim" },
        -- "joshdick/onedark.vim",
        -- "wadackel/vim-dogrun",
        -- { "npxbr/gruvbox.nvim", requires = "rktjmp/lush.nvim" },
        -- "bluz71/vim-nightfly-guicolors",
        "bluz71/vim-moonfly-colors",
        -- { "marko-cerovac/material.nvim" },
        -- "sainnhe/edge",
        -- { "embark-theme/vim", as = "embark" },
        -- "norcalli/nvim-base16.lua",
        "RRethy/nvim-base16",
        -- "novakne/kosmikoa.nvim",
        -- "glepnir/zephyr-nvim",
        -- "ghifarit53/tokyonight-vim"
        "folke/tokyonight.nvim",
        -- "sainnhe/sonokai",
        -- "morhetz/gruvbox",
        -- "arcticicestudio/nord-vim",
        -- "drewtempelmeyer/palenight.vim",
        -- "Th3Whit3Wolf/onebuddy",
        -- "christianchiarulli/nvcode-color-schemes.vim",
        -- "Th3Whit3Wolf/one-nvim",
        -- event = "VimEnter",
        "rebelot/kanagawa.nvim",
        "metalelf0/jellybeans-nvim",
        config = function()
            require("theme")
        end,
    })
    if Packer_bootstrap then
        require('packer').sync()
    end
end
)
