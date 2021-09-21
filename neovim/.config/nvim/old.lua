local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end
local packer = require'packer'
packer.reset()
packer.init({opt_default= true})
packer.startup({function()
use {'wbthomason/packer.nvim', opt= false}
use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope")
    end,
    cmd = { "Telescope" },
    module = "telescope",
    keys = { "<leader><space>", "<leader>fz", "<leader>pp" },
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
      "nvim-telescope/telescope-z.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      
    },
}
use { 'ms-jpq/coq_nvim', branch = 'coq'} -- main one
use { 'ms-jpq/coq.artifacts',opt=false, branch= 'artifacts'} -- 9000+ Snippets
use {
  'hoob3rt/lualine.nvim',opt=false,requires = {'kyazdani42/nvim-web-devicons', opt = true}
}
use {'neovim/nvim-lspconfig',opt=false,event = 'BufReadPre'}
use {'kabouzeid/nvim-lspinstall',opt=false, event='BufRead',
	config = function() require'lspinstall'.setup() -- import lspinstall
 	local servers = require'lspinstall'.installed_servers()
 	for _, server in pairs(servers) do
 	require'lspconfig'[server].setup{
	} --setup each server installed
 end
 end
 }
use {'kyazdani42/nvim-web-devicons'} -- for file icons
use {'kyazdani42/nvim-tree.lua', cmd = "NvimTreeToggle",config = function() require "plugins.nvimtree" end } -- file explorer
use {'honza/vim-snippets'}
use {'windwp/nvim-autopairs',opt=false}
use {'tpope/vim-commentary'}
use {'NLKNguyen/papercolor-theme'}
use {'folke/tokyonight.nvim',opt=false}
use {'bluz71/vim-nightfly-guicolors',opt=false}
use {'ishan9299/nvim-solarized-lua'}
use {'vimwiki/vimwiki'}
use {'plasticboy/vim-markdown'}
use {'ishan9299/modus-theme-vim'}
use {'srcery-colors/srcery-vim'}
use {'junegunn/vim-easy-align'}
use {'tpope/vim-surround',opt=false}
use {'hashivim/vim-terraform'}
use {'folke/which-key.nvim',opt=false,event = 'VimEnter',config = function() require("which-key").setup{} end}
end,
config = {display={open_fn = require('packer.util').float}
}})

vim.o.guifont = 'FiraCode NF:h13'
vim.o.completeopt = "menuone,noselect"
vim.o.number = true
vim.o.showmode = true
vim.o.mouse = "a"
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.cmd('colorscheme tokyonight')

----------LUALINE----------
require('lualine').setup{
options = {
  theme = 'gruvbox',
  section_separators = {'', ''},
  component_separators = {'', ''}
}}

----------NVIM-AUTOPAIRS----------
require('nvim-autopairs').setup()
--require("nvim-autopairs.completion.compe").setup({
--	map_cr = true, --  map <CR> on insert mode
--	map_complete = true -- it will auto insert `(` after select function or method item
--})
----------VIMWIKI----------
vim.g.vimwiki_global_ext = 0 -- do not set filetype to vimwiki for all markdown
vim.g.vimwiki_table_mappings = 0 -- needed for snippets to work! (This was hassling me for days)
vim.g.vimwiki_list = {{ path= '/mnt/c/Users/SriHarshaTolety/Sync/wiki',syntax= 'markdown',ext= '.md'}}
vim.g.vimwiki_ext2syntax = {['.md'] = 'markdown', ['.markdown'] = 'markdown'}

----------NVIM-LSPINSTALL----------

----------WHICH-KEY----------

---------VIM_TERRAFORM-----------
vim.g.terraform_fmt_on_save = 1
------NVIM-COMPE----------
--require'compe'.setup {
--	enabled = true;
--	autocomplete = true;
--	debug = false;
--	min_length = 1;
--	preselect = 'enable';
--	throttle_time = 80;
--	source_timeout = 200;
--	resolve_timeout = 800;
--	incomplete_delay = 400;
--	max_abbr_width = 100;
--	max_kind_width = 100;
--	max_menu_width = 100;
--	documentation = {
--		border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
--		winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
--		max_width = 120,
--		min_width = 60,
--		max_height = math.floor(vim.o.lines * 0.3),
--		min_height = 1,
--	};
--
--	source = {
--		path = true;
--		buffer = true;
--		calc = true;
--		nvim_lsp = true;
--		nvim_lua = true;
--		vsnip = false;
--		ultisnips = true;
--		luasnip = false;
--	};
--}
--vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()',                                                    { noremap = true, silent=true, expr = true})
--vim.api.nvim_set_keymap('i', '<CR>',      'compe#confirm(luaeval("require \'nvim-autopairs\'.autopairs_cr()"))', { noremap = true, silent=true, expr = true})
--vim.api.nvim_set_keymap('i', '<C-e>',     'compe#close(\'<C-e>\')',                                              { noremap = true, silent=true, expr = true})
--vim.api.nvim_set_keymap('i', '<C-f>',     'compe#scroll({ \'delta\': +4 })',                                     { noremap = true, silent=true, expr = true})
--vim.api.nvim_set_keymap('i', '<C-d>',     'compe#scroll({ \'delta\': -4 }',                                      { noremap = true, silent=true, expr = true})
--
--local t = function(str)
--  return vim.api.nvim_replace_termcodes(str, true, true, true)
--end
--
--local check_back_space = function()
--    local col = vim.fn.col('.') - 1
--    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
--end
--
---- Use (s-)tab to:
----- move to prev/next item in completion menuone
----- jump to prev/next snippet's placeholder
--_G.tab_complete = function()
--  if vim.fn.pumvisible() == 1 then
--    return t "<C-n>"
--  elseif vim.fn['vsnip#available'](1) == 1 then
--    return t "<Plug>(vsnip-expand-or-jump)"
--  elseif check_back_space() then
--    return t "<Tab>"
--  else
--    return vim.fn['compe#complete']()
--  end
--end
--_G.s_tab_complete = function()
--  if vim.fn.pumvisible() == 1 then
--    return t "<C-p>"
--  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
--    return t "<Plug>(vsnip-jump-prev)"
--  else
--    -- If <S-Tab> is not working in your terminal, change it to <C-h>
--    return t "<S-Tab>"
--  end
--end
--
--vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
