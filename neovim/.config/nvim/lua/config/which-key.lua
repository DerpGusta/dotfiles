local wk = require("which-key")

wk.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = true, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
		spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
	},
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
})
-- ================================================================================
local opts  = {
	mode = "n",
	prefix = "",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

local lopts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
}
local lmappings = {
	b = { "<cmd>:Telescope buffers<cr>", "Buffers" },
	e = {
		name = "+Edit",
		d = { "<cmd>:lua require('config.telescope-functions').dot_picker()<cr>", "Dotfiles"},
		m = { ":edit ~/.config/nvim/lua/mappings.lua<CR>", "mappings"},
		p = { ":edit ~/.config/nvim/lua/plugins.lua<CR>", "plugin config"},
		v = { "<cmd>:edit $MYVIMRC<cr>", "init.lua"},
	},

	p = {
		name = "+Packer",
		s = { "<cmd>:PackerSync<cr>", "PackerSync" },
		p = { "<cmd>:PackerProfile<cr>", "PackerProfile" },
		S = { "<cmd>:PackerStatus<cr>", "PackerStatus" }
	},
	h = { "<cmd>:nohlsearch<cr>","Toggle Highlight"},
	l = { "<cmd>:NvimTreeToggle<cr>","Toggle NvimTree"},
	r = { "<cmd>:RnvimrToggle<cr>", "Open Rnvimr"},
	t = {
		name = "+Telescope",
		c = { "<cmd>:lua require('config.telescope-functions').color_picker()<cr>", "Colorschemes" },
		f = { "<cmd>:Telescope find_files<cr>", "Files" },
		o = { "<cmd>:Telescope oldfiles<cr>", "Oldfiles" },
		s = { "<cmd>:Telescope symbols<cr>", "Symbols" },
		t = { "<cmd>:Telescope<cr>", "All modules" }
	},
	w = {
		name = "+Wiki",
		n = {"<plug>(wiki-open)", "Open/Create page" },
		w = {"<plug>(wiki-index)", "Index of Wiki" },
		x = {"<plug>(wiki-reload)", "Reload plugin" },
		["<leader>"] = {
			name = "Journal",
			w = {"<plug>(wiki-journal)", "Open Journal" }
		}
	}

}

wk.register(lmappings,lopts)
wk.register(mappings,opts)
